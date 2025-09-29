{ config, pkgs, ... }:
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "30x50";
        origin = "top-right";
        transparency = 10;
        corner_radius = 10;
        font = "Noto Sans 10";
      };
    };
  };
  
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
  };
}
