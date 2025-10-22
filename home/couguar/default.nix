{ inputs, config, pkgs, username, hostname, ... }:

{
  imports = [
    # Shell configuration
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
    ../../modules/home-manager/programs/matugen.nix

    # Desktop environment
    ../../modules/home-manager/desktop/hyprland
    ../../modules/home-manager/desktop/ags
    ../../modules/home-manager/desktop/theme.nix

    # Services
    ../../modules/home-manager/services/udiskie.nix
  ];

  # ═══════════════════════════════════════════════════
  # User Configuration
  # ═══════════════════════════════════════════════════

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
  };

  # ═══════════════════════════════════════════════════
  # XDG Directories
  # ═══════════════════════════════════════════════════

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

  # ═══════════════════════════════════════════════════
  # Environment Variables
  # ═══════════════════════════════════════════════════

  home.sessionVariables = {
    # Wayland settings
    NIXOS_OZONE_WL = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";

    # Qt Wayland
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    # GTK Wayland
    GDK_BACKEND = "wayland,x11";

    # Firefox Wayland
    MOZ_ENABLE_WAYLAND = "1";

    # Default applications
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
  };

  # ═══════════════════════════════════════════════════
  # Directory Placeholders
  # ═══════════════════════════════════════════════════

  home.file = {
    "Pictures/Screenshots/.keep".text = "";
    "Pictures/Wallpapers/.keep".text = "";
    "Documents/Projects/.keep".text = "";
    ".local/share/applications/.keep".text = "";
  };

  programs.home-manager.enable = true;
}
