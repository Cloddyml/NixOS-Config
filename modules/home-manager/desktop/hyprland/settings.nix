{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Модификаторы и переменные
    "$mod" = "SUPER";
    "$terminal" = "kitty";
    "$fileManager" = "thunar";
    
    # ========== МОНИТОРЫ ==========
    monitor = [
      ",preferred,auto,1"
      # Для дополнительного монитора:
      # "HDMI-A-1,1920x1080@60,1920x0,1"
    ];
    
    # ========== ПЕРЕМЕННЫЕ ОКРУЖЕНИЯ ==========
    env = [
      "XCURSOR_SIZE,24"
      "QT_QPA_PLATFORMTHEME,qt6ct"
    ];
    
    # ========== ВНЕШНИЙ ВИД ==========
    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;
      
      # Catppuccin Mocha цвета
      "col.active_border" = "rgba(89b4faee) rgba(cba6f7ee) 45deg";
      "col.inactive_border" = "rgba(313244aa)";
      
      layout = "dwindle";
      resize_on_border = true;
    };
    
    decoration = {
      rounding = 8;
      
      active_opacity = 1.0;
      inactive_opacity = 0.95;
      
      drop_shadow = true;
      shadow_range = 4;
      shadow_render_power = 3;
      "col.shadow" = "rgba(1a1a1aee)";
      
      blur = {
        enabled = true;
        size = 3;
        passes = 1;
        new_optimizations = true;
      };
    };
    
    animations = {
      enabled = true;
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      
      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };
    
    # ========== РАСКЛАДКА ==========
    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };
    
    master = {
      new_status = "master";
    };
    
    # ========== УСТРОЙСТВА ВВОДА ==========
    input = {
      kb_layout = "us,ru";
      kb_options = "grp:alt_shift_toggle";
      
      follow_mouse = 1;
      sensitivity = 0;
      
      touchpad = {
        natural_scroll = true;
        disable_while_typing = true;
        tap-to-click = true;
      };
    };
    
    gestures = {
      workspace_swipe = true;
      workspace_swipe_fingers = 3;
    };
    
    # ========== РАЗНОЕ ==========
    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      force_default_wallpaper = 0;
      vfr = true;
    };
  };
}