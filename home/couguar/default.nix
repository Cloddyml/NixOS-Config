{ inputs, config, pkgs, username, hostname, ... }:

{
  imports = [
    # Shell
    ../../modules/home-manager/shell/zsh.nix
    ../../modules/home-manager/shell/starship.nix
    ../../modules/home-manager/shell/cli-tools.nix
    
    # Programs
    ../../modules/home-manager/programs/git.nix
    ../../modules/home-manager/programs/neovim
    ../../modules/home-manager/programs/kitty.nix
    ../../modules/home-manager/programs/browsers.nix
    ../../modules/home-manager/programs/mpv.nix
    ../../modules/home-manager/programs/fastfetch.nix
    ../../modules/home-manager/programs/matugen.nix  # ← ДОБАВЛЕНО
    
    # Desktop
    ../../modules/home-manager/desktop/hyprland
    
    # AGS вместо Waybar
    ../../modules/home-manager/desktop/ags  # ← ДОБАВЛЕНО
    # ../../modules/home-manager/desktop/waybar  # ← ЗАКОММЕНТИРОВАНО
    
    ../../modules/home-manager/desktop/theme.nix
    
    # Services
    ../../modules/home-manager/services/dunst.nix
    ../../modules/home-manager/services/udiskie.nix
  ];

  # =============== ОСНОВНАЯ ИНФОРМАЦИЯ ===============
  
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
  };

  # =============== XDG ДИРЕКТОРИИ ===============
  
  xdg = {
    enable = true;
    
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

  # =============== ДОПОЛНИТЕЛЬНЫЕ ФАЙЛЫ ===============
  
  home.file = {
    "Pictures/Screenshots/.keep".text = "";
    "Pictures/Wallpapers/.keep".text = "";
    "Documents/Projects/.keep".text = "";
    ".local/share/applications/.keep".text = "";
  };

  # Включаем home-manager
  programs.home-manager.enable = true;
}