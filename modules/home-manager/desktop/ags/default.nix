{ config, pkgs, lib, ... }:
{
  # AGS - Aylur's GTK Shell v2
  programs.ags = {
    enable = true;

    # Path to AGS config
    configDir = ../../../config/ags;

    # AGS dependencies
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

  # Widget dependencies
  home.packages = with pkgs; [
    # System utilities
    libnotify
    playerctl
    pamixer
    jq
    curl

    # Icons
    papirus-icon-theme
  ];
  
  # Создаём директории
  home.file = {
    ".config/ags/.keep".text = "";
    ".cache/ags/.keep".text = "";
  };
  
  # GTK настройки для Material Design
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