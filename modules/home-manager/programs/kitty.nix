{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    
    font = {
      name = "FiraCode Nerd Font";
      size = 12;
    };
    
    settings = {
      # Внешний вид
      background_opacity = "0.9";
      confirm_os_window_close = 0;
      
      # Цвета (Catppuccin Mocha)
      foreground = "#CDD6F4";
      background = "#1E1E2E";
      selection_foreground = "#1E1E2E";
      selection_background = "#F5E0DC";
      
      # Курсор
      cursor = "#F5E0DC";
      cursor_text_color = "#1E1E2E";
      
      # URL
      url_color = "#F5E0DC";
      
      # Поведение
      enable_audio_bell = false;
      window_padding_width = 10;
      
      # Табы
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
    };
    
    keybindings = {
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+w" = "close_tab";
      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+left" = "previous_tab";
    };
  };
}