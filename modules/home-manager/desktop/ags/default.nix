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

    # Icons
    papirus-icon-theme
  ];

  # GTK theme for Material Design
  gtk = {
    enable = true;

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
