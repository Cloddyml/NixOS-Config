# modules/home-manager/programs/matugen.nix
{
  # Копируем шаблоны
  xdg.configFile = {
    "ags/style.scss.template".source = ../../../config/ags/style.scss.template;
    "mpv/mpv.conf.template".source = ../../../config/mpv/mpv.conf.template;
    
    # Создаём недостающие шаблоны
    "hypr/colors.conf.template".text = ''
      # Hyprland Colors - Material Design 3
      $primary = rgb({{colors.primary.default.hex}})
      $surface = rgb({{colors.surface.default.hex}})
      # ... и т.д.
    '';
    
    "kitty/colors.conf.template".text = ''
      # Kitty Colors - Material Design 3
      foreground #{{colors.on_surface.default.hex}}
      background #{{colors.surface.default.hex}}
      # ... и т.д.
    '';
  };
  
  # Обновляем конфиг matugen
  xdg.configFile."matugen/config.toml".text = ''
    [config]
    reload_apps = true
    reload_apps_list = ["ags", "hyprpaper", "kitty"]
    
    # ... (остальное как было)
    
    # Добавляем MPV шаблон
    [[config.templates]]
    input_path = "~/.config/mpv/mpv.conf.template"
    output_path = "~/.config/mpv/colors.conf"
  '';
}