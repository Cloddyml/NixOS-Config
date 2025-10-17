{ config, lib, pkgs, username, ... }:
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    
    # Автоочистка неиспользуемых образов
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };
  
  # Пользователь уже добавлен в группу docker через users.nix
  # Дополнительные инструменты
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}