{ config, lib, pkgs, inputs, ... }:

with lib;
let cfg = config.myconfig.apps.rust;
in {
  options.myconfig.apps.rust = { enable = mkEnableOption "rust"; };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [ rust-overlay.overlays.default ];
    environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
  };
}
