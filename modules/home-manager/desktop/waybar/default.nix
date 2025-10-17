{ config, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    
    settings = [{
      layer = "top";
      position = "top";
      height = 34;
      spacing = 4;
      
      modules-left = [ "hyprland/workspaces" "hyprland/window" ];
      modules-center = [ "clock" ];
      modules-right = [ 
        "pulseaudio" 
        "network" 
        "cpu" 
        "memory" 
        "temperature" 
        "backlight"
        "battery" 
        "tray" 
      ];
      
      "hyprland/workspaces" = {
        format = "{icon}";
        on-click = "activate";
        format-icons = {
          "1" = "󰲠";
          "2" = "󰲢";
          "3" = "󰲤";
          "4" = "󰲦";
          "5" = "󰲨";
          "6" = "󰲪";
          "7" = "󰲬";
          "8" = "󰲮";
          "9" = "󰲰";
          "10" = "󰿬";
        };
      };
      
      "hyprland/window" = {
        format = "{}";
        separate-outputs = true;
        max-length = 50;
      };
      
      clock = {
        format = "{:%H:%M  %d/%m/%Y}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt = "{:%A, %d %B %Y}";
      };
      
      cpu = {
        format = "  {usage}%";
        tooltip = false;
      };
      
      memory = {
        format = "  {}%";
      };
      
      temperature = {
        critical-threshold = 80;
        format = "{icon} {temperatureC}°C";
        format-icons = [ "" "" "" ];
      };
      
      backlight = {
        format = "{icon} {percent}%";
        format-icons = [ "" "" "" "" "" "" "" "" "" ];
      };
      
      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = " {capacity}%";
        format-plugged = " {capacity}%";
        format-alt = "{icon} {time}";
        format-icons = [ "" "" "" "" "" ];
      };
      
      network = {
        format-wifi = "  {essid}";
        format-ethernet = "󰈀  {ipaddr}";
        format-linked = "󰈀  {ifname} (No IP)";
        format-disconnected = "󰖪  Disconnected";
        tooltip-format = "{ifname} via {gwaddr}";
        tooltip-format-wifi = "{essid} ({signalStrength}%)";
      };
      
      pulseaudio = {
        format = "{icon} {volume}%";
        format-bluetooth = "{icon}  {volume}%";
        format-bluetooth-muted = " {icon}";
        format-muted = "  {volume}%";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [ "" "" "" ];
        };
        on-click = "pavucontrol";
      };
      
      tray = {
        spacing = 10;
      };
    }];
    
    style = ''
      * {
        font-family: "FiraCode Nerd Font";
        font-size: 13px;
        min-height: 0;
      }
      
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
      
      #clock {
        color: #89b4fa;
        font-weight: bold;
      }
      
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
      
      #backlight {
        color: #fab387;
      }
      
      #network {
        color: #94e2d5;
      }
      
      #network.disconnected {
        color: #f38ba8;
      }
      
      #pulseaudio {
        color: #a6e3a1;
      }
      
      #pulseaudio.muted {
        color: #f38ba8;
      }
    '';
  };
}