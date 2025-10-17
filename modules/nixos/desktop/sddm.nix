{ config, lib, pkgs, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    
    # Тема (опционально)
    # theme = "breeze";
  };
  
  # Автологин (опционально - раскомментируйте если нужно)
  # services.displayManager.autoLogin = {
  #   enable = true;
  #   user = "couguar";
  # };
}