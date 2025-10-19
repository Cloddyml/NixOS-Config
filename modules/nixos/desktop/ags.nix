{ config, lib, pkgs, ... }:
{
  # AGS - Aylur's GTK Shell
  programs.ags = {
    enable = true;
  };
  
  # Необходимые пакеты для AGS и Material Design
  environment.systemPackages = with pkgs; [
    # AGS зависимости
    bun  # JavaScript runtime для AGS v2
    dart-sass  # Для компиляции SCSS
    fd  # Для поиска файлов
    brightnessctl  # Контроль яркости
    
    # Material Design цвета
    matugen  # Material Design 3 color generation
    
    # Иконки и шрифты для красивого UI
    material-design-icons
    material-symbols
  ];
  
  # Fonts для Material Design
  fonts.packages = with pkgs; [
    material-design-icons
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}