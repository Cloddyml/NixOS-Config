{ config, pkgs, ... }:
{
  programs.waybar.style = ''
    /* ===== ОБЩИЕ НАСТРОЙКИ ===== */
    * {
      font-family: "FiraCode Nerd Font";
      font-size: 13px;
      min-height: 0;
    }
    
    /* ===== ОСНОВНОЙ КОНТЕЙНЕР ===== */
    window#waybar {
      background-color: rgba(30, 30, 46, 0.9);
      border-bottom: 2px solid rgba(137, 180, 250, 0.8);
      color: #cdd6f4;
      transition-property: background-color;
      transition-duration: .5s;
    }
    
    window#waybar.hidden {
      opacity: 0.2;
    }
    
    /* ===== ВОРКСПЕЙСЫ ===== */
    #workspaces button {
      padding: 0 8px;
      background-color: transparent;
      color: #cdd6f4;
      border-bottom: 2px solid transparent;
    }
    
    #workspaces button:hover {
      background: rgba(69, 71, 90, 0.8);
      border-bottom: 2px solid #89b4fa;
    }
    
    #workspaces button.active {
      background-color: rgba(137, 180, 250, 0.3);
      border-bottom: 2px solid #89b4fa;
    }
    
    #workspaces button.urgent {
      background-color: #f38ba8;
    }
    
    /* ===== МОДУЛИ - БАЗОВЫЕ СТИЛИ ===== */
    #window,
    #clock,
    #battery,
    #cpu,
    #memory,
    #temperature,
    #backlight,
    #network,
    #pulseaudio,
    #tray {
      padding: 0 10px;
      margin: 0 2px;
      background-color: rgba(49, 50, 68, 0.8);
      border-radius: 8px;
    }
    
    /* ===== ЧАСЫ ===== */
    #clock {
      color: #89b4fa;
      font-weight: bold;
    }
    
    /* ===== БАТАРЕЯ ===== */
    #battery.charging {
      color: #a6e3a1;
    }
    
    #battery.warning:not(.charging) {
      color: #f9e2af;
    }
    
    #battery.critical:not(.charging) {
      color: #f38ba8;
      animation: blink 1s linear infinite;
    }
    
    @keyframes blink {
      to {
        background-color: rgba(243, 139, 168, 0.8);
      }
    }
    
    /* ===== СИСТЕМА ===== */
    #cpu {
      color: #89dceb;
    }
    
    #memory {
      color: #cba6f7;
    }
    
    #temperature {
      color: #f9e2af;
    }
    
    #temperature.critical {
      color: #f38ba8;
    }
    
    /* ===== ЯРКОСТЬ ===== */
    #backlight {
      color: #fab387;
    }
    
    /* ===== СЕТЬ ===== */
    #network {
      color: #94e2d5;
    }
    
    #network.disconnected {
      color: #f38ba8;
    }
    
    /* ===== ЗВУК ===== */
    #pulseaudio {
      color: #a6e3a1;
    }
    
    #pulseaudio.muted {
      color: #f38ba8;
    }
  '';
}