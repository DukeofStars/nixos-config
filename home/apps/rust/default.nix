{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with lib;
let
  cfg = config.myconfig.apps.rust;
in
{
  options.myconfig.apps.rust = {
    enable = mkEnableOption "rust";
  };

  config = mkIf cfg.enable { home.packages = [ pkgs.rust-bin.stable.latest.default ]; };
}
