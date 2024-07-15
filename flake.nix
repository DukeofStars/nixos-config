{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nosys.url = "github:divnix/nosys";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin-hyprland-colours = {
      url = "github:catppuccin/hyprland";
      flake = false;
    };

    fig.url = "github:DukeofStars/fig";
    dotfiles = {
      url = "github:DukeofStars/dotfiles";
      flake = false;
    };

    stylix.url = "github:danth/stylix";

    # rust-overlay.url = "github:oxalica/rust-overlay/";

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ nosys, ... }:
    nosys (
      inputs
      // {
        inherit inputs;
        systems = [ "x86_64-linux" ];
      }
    ) (import ./outputs.nix);
}
