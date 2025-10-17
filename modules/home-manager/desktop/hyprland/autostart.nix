{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "waybar"
      "dunst"
      "nm-applet --indicator"
      "blueman-applet"
      "hyprpaper"
      "hypridle"
      
      # Автозапуск приложений (опционально)
      # "[workspace 3 silent] discord"
      # "[workspace 3 silent] telegram-desktop"
    ];
  };
}