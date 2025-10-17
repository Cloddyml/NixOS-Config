{ config, pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    
    config = {
      # Качество
      profile = "gpu-hq";
      vo = "gpu";
      hwdec = "auto";
      
      # Интерфейс
      osd-font = "FiraCode Nerd Font";
      osd-font-size = 32;
      osd-bar-h = 2;
      
      # Скриншоты
      screenshot-format = "png";
      screenshot-png-compression = 8;
      screenshot-directory = "~/Pictures/Screenshots";
      
      # Субтитры
      sub-auto = "fuzzy";
      sub-font = "Noto Sans";
      sub-font-size = 44;
      
      # Язык
      alang = "ru,rus,en,eng";
      slang = "ru,rus,en,eng";
    };
    
    bindings = {
      "WHEEL_UP" = "seek 10";
      "WHEEL_DOWN" = "seek -10";
      "Ctrl+WHEEL_UP" = "add volume 2";
      "Ctrl+WHEEL_DOWN" = "add volume -2";
    };
  };
}