{ config, pkgs, ... }:
{
  programs.hyprlock = {
    enable = true;
    
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        grace = 0;
        no_fade_in = false;
      };
      
      background = [
        {
          path = "screenshot";  # Или путь к изображению
          blur_passes = 3;
          blur_size = 7;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];
      
      input-field = [
        {
          size = "300, 50";
          position = "0, -20";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(cdd6f4)";
          inner_color = "rgb(1e1e2e)";
          outer_color = "rgb(89b4fa)";
          outline_thickness = 2;
          placeholder_text = "<i>Введите пароль...</i>";
          shadow_passes = 2;
        }
      ];
      
      label = [
        # Время
        {
          text = ''cmd[update:1000] echo "$(date +"%H:%M")"'';
          color = "rgb(cdd6f4)";
          font_size = 90;
          font_family = "FiraCode Nerd Font";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
        # Дата
        {
          text = ''cmd[update:1000] echo "$(date +"%A, %d %B")"'';
          color = "rgb(cdd6f4)";
          font_size = 25;
          font_family = "FiraCode Nerd Font";
          position = "0, 100";
          halign = "center";
          valign = "center";
        }
        # Имя пользователя
        {
          text = "$USER";
          color = "rgb(cdd6f4)";
          font_size = 20;
          font_family = "FiraCode Nerd Font";
          position = "0, -100";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}