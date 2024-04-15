{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-hyprland-colours = {
      url = "github:catppuccin/hyprland";
      flake = false;
    };

    dotfiles_fig = {
      url = "github:DukeofStars/dotfiles_fig";
      flake = false;
    };

    rust-overlay.url = "github:oxalica/rust-overlay/";
  };

  outputs = { self, nixpkgs, home-manager, rust-overlay, ... }@inputs: {
    # Add formatter (why do you need to add it here?)
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;

    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./systems/default
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.foxtristan = import ./home/home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
        ({ pkgs, ... }: {
          nixpkgs.overlays = [ rust-overlay.overlays.default ];
        })
      ];
    };
  };
}
