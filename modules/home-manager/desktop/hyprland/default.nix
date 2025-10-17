{ config, pkgs, ... }:
{
  imports = [
    ./settings.nix
    ./keybinds.nix
    ./rules.nix
    ./autostart.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./hyprpaper.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
  };
  
  # Необходимые пакеты для Hyprland
  home.packages = with pkgs; [
    # Hyprland ecosystem
    hyprpaper      # Обои
    hyprlock       # Блокировка экрана
    hypridle       # Idle daemon
    hyprpicker     # Цветовой picker
    
    # Утилиты
    wofi           # Application launcher
    grim           # Screenshots
    slurp          # Area selection для скриншотов
    swappy         # Screenshot editor
    wl-clipboard   # Буфер обмена
    brightnessctl  # Контроль яркости
    playerctl      # Media player control
    pamixer        # Audio control
    
    # File manager
    xfce.thunar
    xfce.thunar-volman
    
    # Notification daemon настроен отдельно (dunst)
  ];
}