{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  }
  // (import ./extra-flake-inputs.nix);

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
        # TODO: switch host names and dir names to lowercase
        "YPC2-NIXOS2" = nixpkgs-stable.lib.nixosSystem {
          modules = [ ./hosts/YPC/configuration.nix ];
          specialArgs = {
            pkgsUnstable = pkgs;
            inherit inputs;
          };
        };

        "ypc3" = nixpkgs-stable.lib.nixosSystem {
          modules = [ ./hosts/ypc3/configuration.nix ];
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
        # TODO: after updating host names to lowercase, update here to match
        "alyaman@YPC2-NIXOS2" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./homes/YPC/home.nix
          ];

          extraSpecialArgs.inputs = inputs;
        };

        "alyaman@ypc3" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./homes/ypc3/home.nix
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

      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = import nixpkgs-legacy { system = "aarch64-linux"; };
        modules = [ ./nix-on-droid/yph3/configuration.nix ];
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}
