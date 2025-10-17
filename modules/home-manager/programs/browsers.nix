{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      
      settings = {
        # Приватность
        "privacy.donottrackheader.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        
        # Производительность
        "browser.cache.disk.enable" = true;
        "browser.sessionstore.interval" = 15000;
        
        # Wayland
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
      
      # Расширения можно добавить через nur или home-manager
      # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      #   ublock-origin
      #   bitwarden
      # ];
    };
  };
  
  # Chromium для тестирования
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
    ];
  };
  
  home.packages = with pkgs; [
    # Дополнительные браузеры
    # brave
  ];
}