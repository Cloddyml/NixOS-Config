{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    
    settings = {
      # Модификатор клавиш
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "wofi --show drun";
      
      # ========== МОНИТОРЫ ==========
      monitor = [
        # Автоопределение для ноутбука
        ",preferred,auto,1"
        # Для внешнего монитора (раскомментируйте и настройте):
        # "HDMI-A-1,1920x1080@60,1920x0,1"
      ];
      
      # ========== АВТОЗАПУСК ==========
      exec-once = [
        "waybar"
        "dunst"
        "nm-applet --indicator"
        "blueman-applet"
        # "hyprpaper"  # если настроите обои
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
        
        # Цвета рамок (Catppuccin Mocha)
        "col.active_border" = "rgba(89b4faee) rgba(cba6f7ee) 45deg";
        "col.inactive_border" = "rgba(313244aa)";
        
        layout = "dwindle";
        resize_on_border = true;
      };
      
      decoration = {
        rounding = 8;
        
        # Прозрачность
        active_opacity = 1.0;
        inactive_opacity = 0.95;
        
        # Тени
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
        
        # Размытие
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
      
      # ========== РАСКЛАДКА ОКОН ==========
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
        vfr = true;  # Переменная частота обновления
      };
      
      # ========== КЛАВИАТУРНЫЕ СОЧЕТАНИЯ ==========
      
      # Основные действия
      bind = [
        # Запуск программ
        "$mod, Q, exec, $terminal"
        "$mod, E, exec, $fileManager"
        "$mod, R, exec, $menu"
        "$mod, B, exec, firefox"
        
        # Управление окнами
        "$mod, C, killactive"
        "$mod, M, exit"
        "$mod, V, togglefloating"
        "$mod, F, fullscreen"
        "$mod, P, pseudo"
        "$mod, J, togglesplit"
        
        # Фокус на окна (vim-style)
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
        
        # Переключение воркспейсов
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        
        # Перемещение окон на воркспейсы
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        
        # Специальный воркспейс (scratchpad)
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"
        
        # Скроллинг воркспейсов
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        
        # Скриншоты
        ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
        "$mod, Print, exec, grim -g \"$(slurp)\" ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
        
        # Блокировка экрана
        "$mod, L, exec, hyprlock"
      ];
      
      # Перемещение и ресайз с помощью мыши
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      
      # Медиа клавиши
      bindl = [
        ", XF86AudioMute, exec, pamixer -t"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
      
      bindle = [
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        ", XF86AudioLowerVolume, exec, pamixer -d 5"
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];
      
      # ========== ПРАВИЛА ДЛЯ ОКОН ==========
      
      windowrulev2 = [
        # Floating окна
        "float, class:^(pavucontrol)$"
        "float, class:^(nm-connection-editor)$"
        "float, class:^(blueman-manager)$"
        "float, title:^(Picture-in-Picture)$"
        
        # Размеры floating окон
        "size 800 600, class:^(pavucontrol)$"
        "center, class:^(pavucontrol)$"
        
        # Прозрачность для терминала
        "opacity 0.9 0.9, class:^(kitty)$"
        
        # Firefox PiP
        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "size 640 360, title:^(Picture-in-Picture)$"
        "move 100%-660 100%-380, title:^(Picture-in-Picture)$"
        
        # Steam
        "float, class:^(steam)$, title:^(Friends List)$"
        "float, class:^(steam)$, title:^(Steam Settings)$"
        
        # Discord
        "workspace 3, class:^(discord)$"
        
        # Telegram
        "workspace 3, class:^(org.telegram.desktop)$"
      ];
    };
  };
}