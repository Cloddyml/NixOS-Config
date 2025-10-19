{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # AGS вместо Waybar
      "ags"
      
      # Остальные сервисы
      "nm-applet --indicator"
      "blueman-applet"
      "hyprpaper"
      "hypridle"
      
      # Waypaper для выбора обоев
      # Можно запустить через Super+W
      
      # Автоматически генерируем цвета при запуске
      # если есть текущие обои
      "bash -c 'if [ -f ~/Pictures/Wallpapers/current.jpg ]; then matugen image ~/Pictures/Wallpapers/current.jpg --mode dark --json hex; fi'"
    ];
  };
}