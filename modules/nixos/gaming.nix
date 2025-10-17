{ config, lib, pkgs, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    
    # Совместимость с играми
    gamescopeSession.enable = true;
  };
  
  # GameMode для оптимизации производительности в играх
  programs.gamemode = {
    enable = true;
    enableRenice = true;
  };
  
  # Дополнительные игровые инструменты
  environment.systemPackages = with pkgs; [
    lutris          # Игровая платформа
    mangohud        # Оверлей FPS и мониторинг
    protonup-qt     # Управление Proton версиями
    gamemode        # CLI для GameMode
  ];
  
  # Оптимизация для игр
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}