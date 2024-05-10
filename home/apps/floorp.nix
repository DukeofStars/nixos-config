{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.myconfig.apps.floorp;
in
{
  options.myconfig.apps.floorp = {
    enable = mkEnableOption "floorp";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ floorp ]; };
}
