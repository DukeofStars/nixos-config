{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.myconfig.apps.kitty;
in
{
  options.myconfig.apps.kitty = {
    enable = mkEnableOption "kitty";
  };

  config = mkIf cfg.enable { programs.kitty.enable = true; };
}
