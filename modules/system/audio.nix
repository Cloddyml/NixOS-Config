{ config, lib, pkgs, ... }:
{
  # hardware.pulseaudio.enable = false;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  
  environment.systemPackages = with pkgs; [
    pavucontrol playerctl pamixer alsa-utils
  ];
}
