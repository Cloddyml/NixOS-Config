{ config, pkgs, ... }:
{
  imports = [
    ./settings.nix
    ./keybinds.nix
    ./rules.nix
    ./ags-keybinds.nix     # ← ДОБАВЛЕНО для AGS
    ./ags-autostart.nix    # ← ДОБАВЛЕНО для AGS
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
    grim           # Screenshots
    slurp          # Area selection для скриншотов
    swappy         # Screenshot editor
    wl-clipboard   # Буфер обмена
    brightnessctl  # Контроль яркости
    playerctl      # Media player control
    pamixer        # Audio control
    
    # Waypaper для выбора обоев
    waypaper
    
    # File manager
    xfce.thunar
    xfce.thunar-volman
  ];
}