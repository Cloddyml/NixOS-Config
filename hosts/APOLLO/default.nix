{ inputs, config, pkgs, username, hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # ./disko-config.nix  # Uncomment for fresh install

    # Core system
    ../../modules/nixos/boot.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/audio.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/networking.nix
    ../../modules/nixos/fonts.nix

    # Desktop environment
    ../../modules/nixos/desktop/hyprland.nix
    ../../modules/nixos/desktop/sddm.nix
    ../../modules/nixos/desktop/ags.nix

    # Virtualization
    ../../modules/nixos/virtualisation/docker.nix

    # Development
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/development/python.nix
    ../../modules/nixos/development/rust.nix
    ../../modules/nixos/development/nodejs.nix
  ];

  # ═══════════════════════════════════════════════════
  # Locale & Time
  # ═══════════════════════════════════════════════════

  networking.hostName = hostname;
  time.timeZone = "Europe/Moscow";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
    ];
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # ═══════════════════════════════════════════════════
  # System Packages
  # ═══════════════════════════════════════════════════

  environment.systemPackages = with pkgs; [
    # Core utilities
    wget curl git vim
    htop

    # Network
    networkmanagerapplet

    # Wayland essentials
    wayland
    wayland-protocols

    # Screenshots (used by Hyprland keybinds)
    grim
    slurp
  ];

  # ═══════════════════════════════════════════════════
  # Nix Configuration
  # ═══════════════════════════════════════════════════

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      trusted-users = [ "root" username ];
    };

    # Automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
}