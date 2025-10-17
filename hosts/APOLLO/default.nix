{ inputs, config, pkgs, username, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # ./disko-config.nix  # Раскомментировать для новой установки

    # Системные модули
    ../../modules/nixos/boot.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/fonts.nix
    ../../modules/nixos/desktop/hyprland.nix
    ../../modules/nixos/desktop/sddm.nix
    ../../modules/nixos/virtualisation/docker.nix
    
    # Опциональные модули (раскомментируйте если нужно)
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/development/python.nix
    ../../modules/nixos/development/rust.nix
    ../../modules/nixos/development/nodejs.nix
  ];

  # =============== ОСНОВНЫЕ НАСТРОЙКИ ===============
  
  networking.hostName = hostname;
  
  time.timeZone = "Europe/Moscow";
  
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ 
      "en_US.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
    ];
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # =============== СИСТЕМНЫЕ ПАКЕТЫ ===============
  
  environment.systemPackages = with pkgs; [
    # Основные утилиты
    wget curl git vim
    htop tree unzip zip
    
    # Network tools
    networkmanagerapplet
    
    # Essential для Wayland
    wayland
    wayland-protocols
    wl-clipboard
    
    # Hyprland ecosystem
    grim slurp
    
    # System info
    fastfetch
  ];

  # =============== НАСТРОЙКИ NIX ===============
  
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      trusted-users = [ "root" username ];
    };
    
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs.config.allowUnfree = true;
  
  system.stateVersion = "25.05";
}