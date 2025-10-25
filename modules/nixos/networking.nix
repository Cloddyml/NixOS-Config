{ config, lib, pkgs, ... }:
{
  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
    firewall.enable = true;
    wireless.enable = false;
  };
  
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    speedtest-cli
  ];
  
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
