{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "path:./homes/modules/nixvim";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
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
      username = "alyaman";
    in
    {
      nixosConfigurations."YPC2-NIXOS2" = nixpkgs-stable.lib.nixosSystem {
        modules = [ ./hosts/YPC/configuration.nix ];
        specialArgs = {
          nixpkgs-unstable = pkgs;
          inherit inputs username;
          webuiPort = 11111;
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
            inherit username;
            nixpkgs-unstable = pkgs;
            webuiPort = 11111;
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
