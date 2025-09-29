{ inputs, config, pkgs, ... }:

{
  imports = [
    # Импорт программных конфигураций (пока заглушки)
    ./programs/git
    ./programs/zsh  
    ./programs/neovim
    ./programs/hyprland
    ./programs/waybar
    ./programs/kitty
    
    # Импорт desktop настроек
    ./desktop
    
    # Импорт сервисов
    ./services
  ];

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  # =============== ОСНОВНАЯ ИНФОРМАЦИЯ ===============
  
  home = {
    username = "couguar";
    homeDirectory = "/home/couguar";
    stateVersion = "25.05";
  };

  # =============== XDG ДИРЕКТОРИИ ===============
  
  xdg = {
    enable = true;
    
    # Пользовательские директории
    userDirs = {
      enable = true;
      createDirectories = true;
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      videos = "${config.home.homeDirectory}/Videos";
      desktop = "${config.home.homeDirectory}/Desktop";
      publicShare = "${config.home.homeDirectory}/Public";
      templates = "${config.home.homeDirectory}/Templates";
    };
  };

  # =============== ПЕРЕМЕННЫЕ ОКРУЖЕНИЯ ===============
  
  home.sessionVariables = {
    # Wayland
    NIXOS_OZONE_WL = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    
    # Qt
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    
    # GTK
    GDK_BACKEND = "wayland,x11";
    
    # Mozilla
    MOZ_ENABLE_WAYLAND = "1";
    
    # Editor
    EDITOR = "nvim";
    VISUAL = "nvim";
    
    # Browser
    BROWSER = "firefox";
    
    # Terminal
    TERMINAL = "kitty";
  };

  # =============== ОСНОВНЫЕ ПАКЕТЫ ===============
  
  home.packages = with pkgs; [
    # ===== ОСНОВНЫЕ УТИЛИТЫ =====
    fastfetch              # System info
    btop                   # System monitor
    ranger                 # Terminal file manager
    tree                   # Directory tree
    fd                     # Better find
    jq                     # JSON processor
    
    # ===== МУЛЬТИМЕДИА =====
    mpv                    # Video player
    imv                    # Image viewer
    cava                   # Audio visualizer
    
    # ===== ФАЙЛЫ И АРХИВЫ =====
    unzip zip p7zip #rar
    
    # ===== WAYLAND ИНСТРУМЕНТЫ =====
    wl-clipboard           # Clipboard
    grim                   # Screenshots
    slurp                  # Area selection
    swappy                 # Screenshot editor
    
    # ===== ТЕМЫ И ВНЕШНИЙ ВИД =====
    bibata-cursors         # Cursor theme
    papirus-icon-theme     # Icon theme
    
    # ===== ДОПОЛНИТЕЛЬНЫЕ ШРИФТЫ =====
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.caskaydia-mono
  ];
  # =============== БАЗОВЫЕ ПРОГРАММЫ ===============
  
  programs = {
    # Включаем home-manager
    home-manager.enable = true;
    
    # Терминальные утилиты с настройками
    bat = {
      enable = true;
      config = {
        theme = "TwoDark";
        style = "numbers,changes,header";
      };
    };
    
    eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = "auto";
    };
    
    fzf = {
      enable = true;
      enableZshIntegration = true;
      colors = {
        bg = "#1e1e2e";
        "bg+" = "#313244";
        fg = "#cdd6f4";
        "fg+" = "#cdd6f4";
      };
    };
    
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    
    # Git - базовые настройки
    git = {
      enable = true;
      userName = "couguar";
      userEmail = "ingluemlp@gmail.com";  # Замените на ваш email
      extraConfig = {
        init.defaultBranch = "main";
        core.editor = "nvim";
      };
    };
    
    # Zsh shell
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      
      shellAliases = {
        ll = "eza -la";
        la = "eza -la";
        ls = "eza";
        cat = "bat";
        grep = "rg";
        find = "fd";
      };
    };
    
    # Direnv для проектов
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  # =============== ДОПОЛНИТЕЛЬНЫЕ ФАЙЛЫ ===============
  
  home.file = {
    # Создаем полезные папки
    "Pictures/Screenshots/.keep".text = "";
    "Pictures/Wallpapers/.keep".text = "";
    "Documents/Projects/.keep".text = "";
    ".local/share/applications/.keep".text = "";
  };
}
