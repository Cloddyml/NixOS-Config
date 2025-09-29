{ inputs, config, pkgs, ... }:

{
  imports = [
    # Импортируем существующую аппаратную конфигурацию
    ./hardware-configuration.nix
    
    # Disko config
    # ./disko-config.nix

    # Импорт системных модулей
    ../../modules/system/audio.nix
    ../../modules/system/networking.nix
    ../../modules/system/gaming.nix
  ];

  # =============== ОСНОВНЫЕ НАСТРОЙКИ СИСТЕМЫ ===============
  
  # Имя хоста
  networking.hostName = "APOLLO";
  
  # Часовой пояс
  time.timeZone = "Europe/Moscow";  # Измените на свой
  
  # Локализация
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ 
      "en_US.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
    ];
  };

  # Консольные настройки
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # =============== ЗАГРУЗЧИК ===============
  
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    
    # Поддержка NTFS (для чтения Windows диска)
    supportedFilesystems = [ "ntfs" ];
  };

  # =============== ПОЛЬЗОВАТЕЛИ ===============
  
  users.users.couguar = {
    isNormalUser = true;
    description = "Couguar";
    shell = pkgs.zsh;
    extraGroups = [ 
      "wheel"        # sudo доступ
      "networkmanager"
      "audio" 
      "video"
      "docker"       # для Docker
      "libvirtd"     # для виртуализации
    ];
    # Пароль уже установлен при первичной установке
  };

  # =============== DESKTOP ENVIRONMENT ===============
  
  # X11 и Wayland support
  services.xserver = {
    enable = true;
    
    # Keyboard layout
    xkb = {
      layout = "us,ru";
      options = "grp:alt_shift_toggle";
    };
  };

  # Hyprland window manager
  programs.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # ZSH
  programs.zsh.enable = true;

  # Display manager
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # =============== СИСТЕМНЫЕ СЕРВИСЫ ===============
  
  # NetworkManager уже настроен при установке
  networking.networkmanager.enable = true;
  
  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;
  
  # Printing
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # =============== БЕЗОПАСНОСТЬ ===============
  
  # Polkit для GUI приложений
  security.polkit.enable = true;
  
  # RealtimeKit для аудио
  security.rtkit.enable = true;

  # =============== СИСТЕМНЫЕ ПАКЕТЫ ===============
  
  environment.systemPackages = with pkgs; [
    # Основные утилиты
    wget curl git vim nano neovim
    htop btop tree unzip zip
    
    # Поиск и навигация
    ripgrep fd eza bat fzf
    
    # Network tools
    networkmanagerapplet
    
    # Audio control
    pavucontrol
    
    # File manager
    xfce.thunar
    
    # Terminal emulator
    kitty
    
    # Browsers
    firefox
    
    # Communication
    discord
    telegram-desktop
    
    # Development
    vscode
    docker
    
    # Essential for Wayland
    wayland
    wayland-protocols
    wayland-utils
    wl-clipboard
    
    # Hyprland ecosystem
    waybar          # status bar
    wofi           # launcher
    dunst          # notifications
    grim           # screenshots
    slurp          # area selection
    hyprpaper      # wallpapers
    hyprlock       # screen lock
    hypridle       # idle management
    
    # System info
    fastfetch
    
    # XDG portal
    xdg-desktop-portal
    xdg-desktop-portal-gtk
  ];
  # =============== ШРИФТЫ ===============
  
  fonts = {
    packages = with pkgs; [
      # Основные шрифты
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      
      # Программистские шрифты
      fira-code
      fira-code-symbols
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
    ];
    
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "FiraCode Nerd Font" "Fira Code" ];
        sansSerif = [ "Noto Sans" "Liberation Sans" ];
        serif = [ "Noto Serif" "Liberation Serif" ];
      };
    };
  };

  # =============== ВИРТУАЛИЗАЦИЯ ===============
  
  # Docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  # =============== НАСТРОЙКИ NIX ===============
  
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      
      # Trusted users для flakes
      trusted-users = [ "root" "couguar" ];
    };
    
    # Автоматическая очистка старых поколений
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Разрешаем unfree пакеты
  nixpkgs.config.allowUnfree = true;

  # =============== ВЕРСИЯ СИСТЕМЫ ===============
  
  system.stateVersion = "25.05";
}
