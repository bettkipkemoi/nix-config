# nix-config

A complete Nix flakes configuration for macOS using nix-darwin and home-manager.

## Features

- **System Configuration**: Complete macOS system settings via nix-darwin
- **User Configuration**: Personal development environment via home-manager
- **Declarative Package Management**: All packages and tools defined in code
- **Reproducible Environment**: Same setup on any Mac

## System Settings Configured

### macOS Defaults
- **Dock**: Auto-hide enabled, optimized size, no recent apps
- **Finder**: Show all extensions, path bar, status bar, list view by default
- **Keyboard**: Fast key repeat, caps lock remapped to control
- **Trackpad**: Tap to click, three-finger drag enabled
- **General**: Disable auto-correct, expand save/print dialogs by default

### Included Packages

**System Level:**
- Essential tools: vim, git, curl, wget, tree, htop
- Modern CLI: eza, fzf, ripgrep, fd, bat
- Development: jq

**User Level:**
- Archives: zip, unzip
- Utilities: tmux, neofetch, ranger
- Network: nmap

### Shell Configuration
- **Zsh** with completion, syntax highlighting, and autosuggestions
- **Starship** prompt for beautiful terminal UI
- **Direnv** for project-specific environments
- Custom aliases for common commands

## Prerequisites

1. **Install Nix** (if not already installed):
   ```bash
   sh <(curl -L https://nixos.org/nix/install)
   ```

2. **Install nix-darwin**:
   ```bash
   nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
   ./result/bin/darwin-installer
   ```

## Installation

1. **Clone this repository**:
   ```bash
   git clone https://github.com/bettkipkemoi/nix-config.git ~/.config/nix-config
   cd ~/.config/nix-config
   ```

2. **Update username and personal information** in the configuration files:
   - Edit `flake.nix`: Change `runner` to your macOS username (line 22)
   - Edit `home.nix`: Update `home.username` and `home.homeDirectory` (lines 6-7)
   - **REQUIRED**: Edit `home.nix`: Update git configuration with your name and email (lines 38-39)

3. **Build and apply the configuration**:
   ```bash
   darwin-rebuild switch --flake ~/.config/nix-config#simple
   ```

4. **Restart your terminal** to apply all changes

## Usage

### Update the system configuration:
```bash
darwin-rebuild switch --flake ~/.config/nix-config#simple
```

Or use the alias (after first installation):
```bash
update
```

### Update flake inputs:
```bash
cd ~/.config/nix-config
nix flake update
darwin-rebuild switch --flake .#simple
```

### Add new packages:
- For system-wide packages: Edit `darwin-configuration.nix`
- For user packages: Edit `home.nix`

### Rollback to previous generation:
```bash
darwin-rebuild --rollback
```

### List generations:
```bash
darwin-rebuild --list-generations
```

## Customization

### System Settings
Edit `darwin-configuration.nix` to customize:
- Dock behavior
- Finder preferences
- Keyboard and trackpad settings
- System packages

### User Settings
Edit `home.nix` to customize:
- Shell configuration
- Git settings
- Personal packages
- Program configurations

### Host-specific Configuration
To manage multiple machines, create separate configuration files:
```nix
darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem {
  modules = [ ./hosts/macbook.nix ];
};
```

## File Structure

```
.
├── flake.nix                 # Main flake configuration
├── darwin-configuration.nix  # macOS system settings
├── home.nix                  # Home-manager user configuration
├── .gitignore               # Git ignore rules
└── README.md                # This file
```

## Troubleshooting

### Nix command not found
Ensure nix is properly installed and your shell is configured:
```bash
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

### Permission issues
Make sure you have admin rights and run with your user account (not root).

### Flake evaluation errors
Check your syntax and ensure all file references are correct:
```bash
nix flake check
```

## Resources

- [nix-darwin Documentation](https://github.com/LnL7/nix-darwin)
- [home-manager Documentation](https://github.com/nix-community/home-manager)
- [Nix Flakes Documentation](https://nixos.wiki/wiki/Flakes)
- [macOS System Defaults](https://macos-defaults.com/)

## License

This configuration is free to use and modify for your own purposes.
