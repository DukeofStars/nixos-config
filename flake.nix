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

    dotfiles_fig = {
      url = "github:DukeofStars/dotfiles_fig";
      flake = false;
    };

    rust-overlay.url = "github:oxalica/rust-overlay/";
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
