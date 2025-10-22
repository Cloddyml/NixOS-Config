{ inputs, config, pkgs, lib, ... }:
{
  # Import AGS v1 home-manager module
  imports = [ inputs.ags.homeManagerModules.default ];

  # AGS - Aylur's GTK Shell v1 (stable)
  programs.ags = {
    enable = true;

    # Symlink to ~/.config/ags
    configDir = ../../../config/ags;

    # Additional packages for AGS widgets
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

  # Widget dependencies
  home.packages = with pkgs; [
    # System utilities
    playerctl
    pamixer
    jq
    curl
    libnotify

    # Icons & themes
    papirus-icon-theme
    adw-gtk3  # Material Design GTK theme (configured in theme.nix)
  ];
}
