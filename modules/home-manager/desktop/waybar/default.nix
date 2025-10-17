{ config, pkgs, ... }:
{
  imports = [
    ./style.nix
  ];

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
  };
}