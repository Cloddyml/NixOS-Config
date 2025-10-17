{ inputs, config, lib, pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    
    # Если хотите использовать flake версию Hyprland, раскомментируйте:
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  
  # X11 поддержка (для совместимости с некоторыми приложениями)
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us,ru";
      options = "grp:alt_shift_toggle";
    };
  };
  
  # Polkit для GUI приложений (требуется для административных действий)
  security.polkit.enable = true;
  
  # XDG Desktop Portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  
  # Дополнительные пакеты для Hyprland
  environment.systemPackages = with pkgs; [
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
  ];
}