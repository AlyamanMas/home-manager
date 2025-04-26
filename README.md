# NixOS Configuration

This repository contains the NixOS and Home Manager configurations for my systems. It's organized as a Nix Flake, allowing for reproducible and declarative system management.

## Project Structure

```
.
├── flake.nix           # Main entry point for the Nix Flake
├── flake.lock          # Dependency lock file
├── homes/              # Home Manager configurations
│   ├── modules/        # Reusable modules for Home Manager
│   └── YPC/            # User-specific home configuration
├── hosts/              # NixOS system configurations
│   ├── modules/        # Reusable modules for system configurations
│   ├── YPC/            # Configuration for YPC2-NIXOS2 machine
│   └── YVPSH/          # Configuration for YVPSH machine
└── secrets/            # Encrypted secrets (managed by git-crypt)
```

## Systems

### YPC2-NIXOS2

A desktop NixOS system with the following features:

- Hyprland desktop environment (with GNOME as an alternative)
- Hardware-accelerated video decoding
- Development tools and environment
- Local network configurations

### YVPSH

Managed via Colmena for remote deployment.

## Home Manager Configuration

The personal configuration for user `alyaman` includes:

- Environment variables and shells
- Various program configurations
- Development tools and utilities

## Key Features

- **Modular Design**: Configurations are split into reusable modules
- **Multiple Desktop Environments**: Support for both GNOME and Hyprland
- **Specializations**: Different system configurations (like Intel-only mode)
- **Secret Management**: Using git-crypt for sensitive information
- **Multiple System Support**: Manages different machines with shared modules

## Usage

### Applying System Configuration

```bash
sudo nixos-rebuild switch --flake .#YPC2-NIXOS2
```

### Updating Home Configuration

```bash
home-manager switch --flake .#alyaman
```

### Deploying to YVPSH Using Colmena

```bash
colmena apply --impure
```

Make sure that yvpsh is defined as a host in the ssh configuration file.

## Dependencies

- NixOS (Unstable and 24.11 channels)
- Home Manager
- Various input flakes:
  - Nixvim
  - HyprPanel
  - Zen-browser
  - Rose-pine-hyprcursor

## Development

The repository uses pre-commit hooks and includes a formatter configuration for consistent code style.

```bash
nix fmt  # Format Nix code according to RFC style
```

## State Version

Both NixOS and Home Manager configurations use state version 24.05.

## License

This configuration is for personal use, but feel free to use it as a reference for your own configurations.
