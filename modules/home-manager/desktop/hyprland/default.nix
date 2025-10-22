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
  
  # Hyprland ecosystem packages
  home.packages = with pkgs; [
    # Core utilities
    hyprpaper
    hyprlock
    hypridle
    hyprpicker
    swappy

    # Wallpaper picker
    waypaper

    # File manager
    xfce.thunar
    xfce.thunar-volman
  ];
}