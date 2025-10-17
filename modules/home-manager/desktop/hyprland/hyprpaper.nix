{ config, pkgs, lib, ... }:
{
  services.hyprpaper = {
    enable = true;
    
    settings = {
      # Предзагрузка обоев
      preload = [
        "~/Pictures/Wallpapers/default.jpg"
        # Добавьте больше путей если нужно несколько обоев
      ];
      
      # Установка обоев для мониторов
      wallpaper = [
        ",~/Pictures/Wallpapers/default.jpg"
        # Для дополнительного монитора:
        # "HDMI-A-1,~/Pictures/Wallpapers/monitor2.jpg"
      ];
      
      # Опции
      splash = false;
      ipc = "on";
    };
  };
  
  # Создаём папку для обоев
  home.file."Pictures/Wallpapers/.keep".text = "";
  
  # ВАЖНО: Положите ваши обои в ~/Pictures/Wallpapers/
  # и переименуйте один в default.jpg
  # Или измените пути выше на свои

  home.activation.createWallpaperFallback = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -f "$HOME/Pictures/Wallpapers/default.jpg" ]; then
      $DRY_RUN_CMD mkdir -p "$HOME/Pictures/Wallpapers"
      $DRY_RUN_CMD echo "ВНИМАНИЕ: Поместите изображение в ~/Pictures/Wallpapers/default.jpg"
    fi
  '';
}
