{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Кейбинды для AGS виджетов
    bind = [
      # Overview - показать все окна
      "$mod, Tab, exec, ags -t overview"
      "ALT, Tab, exec, ags -t overview"
      
      # Quick Settings - боковая панель
      "$mod, A, exec, ags -t quicksettings"
      
      # Смена обоев и генерация цветов
      "$mod, W, exec, waypaper"
      
      # Перезапуск AGS (полезно при разработке)
      "$mod SHIFT, R, exec, ags quit; ags"
    ];
    
    # Window rules для AGS
    windowrulev2 = [
      # Overview
      "float, class:^(ags)$, title:^(overview)$"
      "size 100% 100%, class:^(ags)$, title:^(overview)$"
      "center, class:^(ags)$, title:^(overview)$"
      "animation slide, class:^(ags)$, title:^(overview)$"
      
      # Quick Settings
      "float, class:^(ags)$, title:^(quicksettings)$"
      "size 400 600, class:^(ags)$, title:^(quicksettings)$"
      "move 100%-410 50, class:^(ags)$, title:^(quicksettings)$"
      "animation slide right, class:^(ags)$, title:^(quicksettings)$"
    ];
    
    # Layer rules для AGS
    layerrule = [
      "blur, ags-bar"
      "blur, ags-overview"
      "ignorezero, ags-bar"
      "ignorezero, ags-overview"
    ];
  };
}