# NixOS Configuration - APOLLO

Modern NixOS configuration with Hyprland window manager and AGS (Aylur's GTK Shell) v1.

## Features

- **Hyprland** - Dynamic tiling Wayland compositor
- **AGS v1** - Material Design inspired interface
  - Top bar with workspaces, media player, system info
  - Quick settings panel (Super+A)
  - Window overview (Super+Tab)
  - System statistics (CPU, RAM, Temperature)
- **Material Design 3** - Dynamic theming with `matugen`
- **Development tools** - Python, Rust, Node.js

## Quick Start

### Build Configuration

```bash
# Update flake inputs
nix flake update

# Build system configuration (without activating)
sudo nixos-rebuild build --flake .#APOLLO

# Apply configuration
sudo nixos-rebuild switch --flake .#APOLLO
```

### Update Home Manager

```bash
home-manager switch --flake .#couguar@APOLLO
```

## Configuration Structure

```
.
├── flake.nix              # Main flake configuration
├── hosts/
│   └── APOLLO/            # Host-specific config
├── home/
│   └── couguar/           # User-specific config
├── modules/
│   ├── nixos/             # System-level modules
│   └── home-manager/      # User-level modules
└── config/
    ├── ags/               # AGS v1 configuration
    └── mpv/               # MPV configuration
```

## AGS Configuration

This setup uses **AGS v1** (stable) because:
- Compatible with existing JavaScript widgets
- More documentation and examples available
- Stable API (v2 requires complete rewrite)

### AGS Widgets

- **Bar** - Top panel with workspaces, active window, clock, media player, system tray
- **Media Player** - Shows currently playing music with album art
- **Quick Settings** - Volume, brightness, WiFi, Bluetooth, system stats
- **Overview** - Window switcher with search
- **Notifications** - Material Design notification popups

### Material Design Theming

Colors are dynamically generated from wallpaper using `matugen`:

```bash
# Generate theme from wallpaper
matugen image ~/Pictures/Wallpapers/current.jpg --mode dark --json hex

# Or use waypaper to set wallpaper (Super+W)
waypaper
```

## Troubleshooting

### Build Errors

If you encounter build errors:

1. **Update inputs**: `nix flake update`
2. **Clean build cache**: `sudo nix-collect-garbage -d`
3. **Rebuild**: `sudo nixos-rebuild switch --flake .#APOLLO --show-trace`

### AGS Issues

If AGS doesn't start:

```bash
# Check AGS status
systemctl --user status ags

# Restart AGS
systemctl --user restart ags

# Check logs
journalctl --user -u ags -f
```

## Key Bindings

### Window Management
- `Super + Q` - Terminal (kitty)
- `Super + C` - Close window
- `Super + V` - Toggle floating
- `Super + F` - Fullscreen
- `Super + 1-9` - Switch workspace
- `Super + Shift + 1-9` - Move window to workspace

### AGS
- `Super + Tab` / `Alt + Tab` - Window overview
- `Super + A` - Quick settings
- `Super + W` - Wallpaper picker
- `Super + Shift + R` - Restart AGS

### Screenshots
- `Print` - Area screenshot to clipboard
- `Super + Print` - Area screenshot to file

## Credits

Inspired by:
- [end-4/dots-hyprland](https://github.com/end-4/dots-hyprland) - Material Design approach
- [Aylur/ags](https://github.com/Aylur/ags) - AGS framework

## License

MIT
