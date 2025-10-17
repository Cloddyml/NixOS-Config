{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      # Floating окна
      "float, class:^(pavucontrol)$"
      "float, class:^(nm-connection-editor)$"
      "float, class:^(blueman-manager)$"
      "float, title:^(Picture-in-Picture)$"
      
      # Размеры для floating окон
      "size 800 600, class:^(pavucontrol)$"
      "center, class:^(pavucontrol)$"
      
      # Прозрачность
      "opacity 0.9 0.9, class:^(kitty)$"
      "opacity 0.95 0.95, class:^(Code)$"
      
      # Firefox Picture-in-Picture
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"
      "size 640 360, title:^(Picture-in-Picture)$"
      "move 100%-660 100%-380, title:^(Picture-in-Picture)$"
      
      # Steam
      "float, class:^(steam)$, title:^(Friends List)$"
      "float, class:^(steam)$, title:^(Steam Settings)$"
      
      # Назначение воркспейсов для приложений
      "workspace 2, class:^(Code)$"
      "workspace 3, class:^(discord)$"
      "workspace 3, class:^(org.telegram.desktop)$"
      "workspace 4, class:^(steam)$"
    ];
    
    # Layer rules для оверлеев
    layerrule = [
      "blur, waybar"
      "blur, wofi"
      "ignorezero, waybar"
      "ignorezero, wofi"
    ];
  };
}