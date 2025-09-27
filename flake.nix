{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
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
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixpkgs-stable,
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
      nixosConfigurations."YPC2-NIXOS2" = nixpkgs-stable.lib.nixosSystem {
        modules = [ ./hosts/YPC/configuration.nix ];
        specialArgs = {
          nixpkgs-unstable = pkgs;
          inherit inputs;
        };
      };

      nixosConfigurations."YVPSH" = nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/YVPSH/configuration.nix ];
        specialArgs = {
          nixpkgs-unstable = pkgs;
        };
      };

      homeConfigurations."alyaman" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./homes/YPC/home.nix
        ];

        extraSpecialArgs.inputs = inputs;
      };

      colmena = {
        meta = {
          nixpkgs = pkgs;

          specialArgs = {
            nixpkgs-unstable = pkgs;
          };
        };

        yvpsh =
          { name, nodes, ... }:
          {
            imports = [
              ./hosts/YVPSH/configuration.nix
            ];
          };
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}
