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

  # Widget dependencies for AGS
  home.packages = with pkgs; [
    # Media & audio control (for AGS widgets)
    playerctl
    pamixer
    brightnessctl

    # Utilities
    jq
    curl
    libnotify
  ];
}
