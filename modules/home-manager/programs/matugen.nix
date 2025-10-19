{ config, pkgs, lib, ... }:
{
  # Matugen для Material Design 3 цветов из обоев
  home.packages = with pkgs; [
    matugen
  ];
  
  # Конфигурация matugen
  xdg.configFile."matugen/config.toml".text = ''
    [config]
    reload_apps = true
    reload_apps_list = ["ags", "hyprpaper", "kitty", "mpv"]
    
    [config.reload]
    ags = "ags quit; ags"
    hyprpaper = "killall hyprpaper; hyprpaper"
    kitty = "killall -SIGUSR1 kitty"
    mpv = "killall -SIGUSR1 mpv || true"
    
    # Шаблоны для генерации
    [[config.templates]]
    input_path = "~/.config/ags/style.scss.template"
    output_path = "~/.config/ags/style.scss"
    
    [[config.templates]]
    input_path = "~/.config/hypr/colors.conf.template"
    output_path = "~/.config/hypr/colors.conf"
    
    [[config.templates]]
    input_path = "~/.config/kitty/colors.conf.template"
    output_path = "~/.config/kitty/colors.conf"
    
    [[config.templates]]
    input_path = "~/.config/mpv/mpv.conf.template"
    output_path = "~/.config/mpv/colors.conf"
  '';
  
  # Скрипт для смены обоев и генерации цветов
  home.file.".local/bin/wallpaper-set" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      
      # Проверяем аргумент
      if [ -z "$1" ]; then
        echo "Usage: wallpaper-set <path-to-wallpaper>"
        exit 1
      fi
      
      WALLPAPER="$1"
      
      # Копируем обои в стандартное место
      mkdir -p ~/Pictures/Wallpapers
      cp "$WALLPAPER" ~/Pictures/Wallpapers/current.jpg
      
      # Генерируем цвета через matugen
      matugen image "$WALLPAPER" --mode dark --json hex
      
      # Применяем обои через hyprpaper
      hyprctl hyprpaper wallpaper ",~/Pictures/Wallpapers/current.jpg"
      
      echo "✓ Wallpaper set and colors generated!"
    '';
  };
  
  # Создаём папку для кеша
  home.file.".cache/matugen/.keep".text = "";
}