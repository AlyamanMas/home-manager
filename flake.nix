{
  inputs = {
    # basics {{{
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-alyamanmas = {
      url = "github:AlyamanMas/nixpkgs/init-nunito-sans";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # }}}

    # extra {{{
    "git-aliases.nu" = {
      url = "github:KamilKleina/git-aliases.nu";
      flake = false;
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # TODO: bump to 0.7.0 or above when it becomes stable
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
    helium = {
      url = "github:vikingnope/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # }}}
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      home-manager,
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
      nixosConfigurations =
        let
          ypc2System = nixpkgs-stable.lib.nixosSystem {
            modules = [ ./hosts/ypc2/configuration.nix ];
            specialArgs = {
              pkgsUnstable = pkgs;
              inherit inputs;
            };
          };
        in
        {
          # TODO: remove this when ypc2 switches its hostname to ypc2
          "YPC2-NIXOS2" = ypc2System;
          "ypc2" = ypc2System;

          "ypc3" = nixpkgs-stable.lib.nixosSystem {
            modules = [ ./hosts/ypc3/configuration.nix ];
            specialArgs = {
              pkgsUnstable = pkgs;
              inherit inputs;
            };
          };

          "yvpsh" = nixpkgs.lib.nixosSystem {
            modules = [ ./hosts/yvpsh/configuration.nix ];
            specialArgs = {
              pkgsUnstable = pkgs;
            };
          };
        };

      homeConfigurations =
        let
          ypc2Home = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              ./homes/ypc2/home.nix
            ];

            extraSpecialArgs.inputs = inputs;
          };
        in
        {
          # TODO: remove this when ypc2 switches its hostname to ypc2
          "alyaman@YPC2-NIXOS2" = ypc2Home;
          "alyaman@ypc2" = ypc2Home;

          "alyaman@ypc3" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              ./homes/ypc3/home.nix
            ];

            extraSpecialArgs.inputs = inputs;
          };
        };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}
# vim: foldmethod=marker
