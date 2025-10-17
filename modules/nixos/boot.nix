{ config, lib, pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    
    # Поддержка NTFS (для чтения Windows диска)
    supportedFilesystems = [ "ntfs" ];
    
    # Plymouth для красивого экрана загрузки (опционально)
    # plymouth.enable = true;
  };
}