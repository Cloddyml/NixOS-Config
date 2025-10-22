{ config, lib, pkgs, ... }:
{
  # AGS system-level dependencies
  # AGS itself is configured via home-manager

  environment.systemPackages = with pkgs; [
    # AGS runtime
    bun        # JavaScript runtime for AGS v2
    dart-sass  # SCSS compilation
    fd         # File search

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