{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.myconfig.services.darling;
in
{
  options.myconfig.services.darling = {
    enable = mkEnableOption "darling";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      darling-dmg
      darling
    ];
  };
}