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

  _nixosConfigurations = {
    default = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./systems/default
        inputs.stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.foxtristan = import ./home/home.nix;
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };
          home-manager.backupFileExtension = "bak";
        }
        (
          { pkgs, ... }:
          {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
          }
        )
      ];
    };
    queen-bee = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./systems/queen-bee
        home-manager.nixosModules.home-manager
      ];
    };
    installerIso = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"

        ({
          users.users.nixos = {
            openssh.authorizedKeys.keys = [
              "ssh-ed25519 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOGTJACDI9vBzqiwkoyQfCivSKpLVCY5lOKrtVF9Z1PZ"
            ];
          };
          services.openssh.enable = true;
          networking.wireless = {
            enable = true;
            userControlled.enable = true;
            networks."FoxHub-5G" = {
              pskRaw = "5360eb5a78406dc010a3a0af8e0be1dfe5fbf4e1fbd156ad5122a9692a4f5240";
            };
          };
        })
      ];
    };
  };
}
