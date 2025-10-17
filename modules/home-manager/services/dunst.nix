{ config, pkgs, ... }:
{
  services.dunst = {
    enable = true;
    
    settings = {
      global = {
        # Размещение
        width = 300;
        height = 300;
        offset = "30x50";
        origin = "top-right";
        
        # Прогресс-бар
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        
        # Внешний вид
        transparency = 10;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        frame_width = 2;
        corner_radius = 10;
        
        # Шрифт и текст
        font = "FiraCode Nerd Font 10";
        line_height = 0;
        markup = "full";
        format = "<b>%s</b>\\n%b";
        alignment = "left";
        vertical_alignment = "center";
        
        # Иконки
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 64;
        
        # История
        show_age_threshold = 60;
        show_indicators = true;
        sticky_history = true;
        history_length = 20;
        
        # Поведение
        dmenu = "${pkgs.wofi}/bin/wofi -dmenu";
        browser = "${pkgs.firefox}/bin/firefox";
        mouse_left_click = "do_action";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
      };
      
      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#89b4fa";
        timeout = 5;
      };
      
      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#89b4fa";
        timeout = 10;
      };
      
      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#f38ba8";
        timeout = 0;
      };
    };
  };
}