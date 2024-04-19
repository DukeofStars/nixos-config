{
  inputs,
  home-manager,
  rust-overlay,
  nixpkgs,
  ...
}:

let
  inherit (nixpkgs.legacyPackages) pkgs;
in
{
  formatter = pkgs.nixfmt-rfc-style;
  devShells.default = pkgs.mkShell { buildInputs = with pkgs; [ nil ]; };

  _nixosConfigurations.default = nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
    };
    modules = [
      ./systems/default
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.foxtristan = import ./home/home.nix;
        home-manager.extraSpecialArgs = {
          inherit inputs;
        };
      }
      (
        { pkgs, ... }:
        {
          nixpkgs.overlays = [ rust-overlay.overlays.default ];
        }
      )
    ];
  };
}
