{ config, lib, pkgs, ... }:
{
  # AGS system-level dependencies
  # AGS v1 is configured via home-manager

  environment.systemPackages = with pkgs; [
    # SCSS compilation for AGS styling
    dart-sass

    # Material Design theming
    matugen

    # Icons
    material-design-icons
    material-symbols
  ];

  # Material Design fonts
  fonts.packages = with pkgs; [
    material-design-icons
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}