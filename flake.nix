{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
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
          pkgsUnstable = pkgs;
          inherit inputs;
        };
      };

      nixosConfigurations."YPC3-NIXOS" = nixpkgs-stable.lib.nixosSystem {
        modules = [ ./hosts/YPC3/configuration.nix ];
        specialArgs = {
          pkgsUnstable = pkgs;
          inherit inputs;
        };
      };

      nixosConfigurations."YVPSH" = nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/YVPSH/configuration.nix ];
        specialArgs = {
          pkgsUnstable = pkgs;
        };
      };

      homeConfigurations."alyaman" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./homes/YPC/home.nix
        ];

        extraSpecialArgs.inputs = inputs;
      };

      homeConfigurations."alyaman@YPC3-NIXOS" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./homes/YPC3/home.nix
        ];

        extraSpecialArgs.inputs = inputs;
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}
