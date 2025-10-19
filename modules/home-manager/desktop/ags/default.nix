{ config, pkgs, lib, ... }:
{
  # AGS конфигурация
  programs.ags = {
    enable = true;
    
    # Используем AGS v2
    # configDir = ./config;  # Раскомментируй после создания config/
    
    # Дополнительные пакеты для AGS
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };
  
  # Необходимые пакеты для виджетов
  home.packages = with pkgs; [
    # Для Overview и скриншотов
    grim
    slurp
    swappy
    
    # Для уведомлений и медиа
    libnotify
    playerctl
    pamixer
    
    # Иконки
    papirus-icon-theme
    
    # Для погоды и других виджетов
    jq
    curl
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