{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Основные действия
    bind = [
      # Запуск программ
      "$mod, Q, exec, $terminal"
      "$mod, E, exec, $fileManager"
      "$mod, B, exec, firefox"
      
      # Управление окнами
      "$mod, C, killactive"
      "$mod, M, exit"
      "$mod, V, togglefloating"
      "$mod, F, fullscreen"
      "$mod, P, pseudo"
      "$mod, J, togglesplit"
      
      # Фокус (vim-style)
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"
      "$mod, h, movefocus, l"
      "$mod, l, movefocus, r"
      "$mod, k, movefocus, u"
      "$mod, j, movefocus, d"
      
      # Воркспейсы
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
      
      # Scratchpad
      "$mod, S, togglespecialworkspace, magic"
      "$mod SHIFT, S, movetoworkspace, special:magic"
      
      # Скриншоты
      ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
      "$mod, Print, exec, grim -g \"$(slurp)\" ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
      
      # Блокировка (если используете hyprlock)
      "$mod, L, exec, hyprlock"
    ];
    
    # Мышь
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
    
    # Медиа клавиши (без повтора)
    bindl = [
      ", XF86AudioMute, exec, pamixer -t"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
    
    # Яркость и громкость (с повтором при удержании)
    bindle = [
      ", XF86AudioRaiseVolume, exec, pamixer -i 5"
      ", XF86AudioLowerVolume, exec, pamixer -d 5"
      ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
      ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
    ];
  };
}