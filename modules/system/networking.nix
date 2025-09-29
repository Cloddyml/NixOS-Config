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
    networkmanagerapplet wget curl speedtest-cli
  ];
  
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
