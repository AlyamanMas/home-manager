{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    # required for nix-on-droid until new versions are supported
    nixpkgs-legacy.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixvim = {
      url = "github:nix-community/nixvim";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.hyprlang.follows = "hyprland/hyprlang";
    };
    "git-aliases.nu" = {
      url = "github:KamilKleina/git-aliases.nu";
      flake = false;
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-legacy";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      nixpkgs-legacy,
      home-manager,
      nix-on-droid,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        "YPC2-NIXOS2" = nixpkgs-stable.lib.nixosSystem {
          modules = [ ./hosts/YPC/configuration.nix ];
          specialArgs = {
            pkgsUnstable = pkgs;
            inherit inputs;
          };
        };

        "YPC3-NIXOS" = nixpkgs-stable.lib.nixosSystem {
          modules = [ ./hosts/YPC3/configuration.nix ];
          specialArgs = {
            pkgsUnstable = pkgs;
            inherit inputs;
          };
        };

        "YVPSH" = nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/YVPSH/configuration.nix ];
          specialArgs = {
            pkgsUnstable = pkgs;
          };
        };
      };

      homeConfigurations = {
        "alyaman@YPC2-NIXOS2" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./homes/YPC/home.nix
          ];

          extraSpecialArgs.inputs = inputs;
        };

        "alyaman@YPC3-NIXOS" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./homes/YPC3/home.nix
          ];

          extraSpecialArgs.inputs = inputs;
        };

        "nix-on-droid" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-linux";
            config.allowUnfree = true;
          };
          modules = [
            ./homes/yph3/home.nix
          ];
        };
      };

      nixOnDroidConfigurations.default = nix-on-droid.nixOnDroidConfiguration {
        pkgs = import nixpkgs-legacy { system = "aarch64-linux"; };
        modules = [ ./nix-on-droid/yph3/configuration.nix ];
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}
