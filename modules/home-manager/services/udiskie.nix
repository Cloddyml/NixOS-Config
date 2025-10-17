{ config, pkgs, ... }:
{
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
    tray = "auto";
    
    settings = {
      program_options = {
        udisks_version = 2;
      };
      
      device_config = [
        {
          id_uuid = "*";
          ignore = false;
        }
      ];
    };
  };
}