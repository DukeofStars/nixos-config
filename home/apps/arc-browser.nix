{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.myconfig.apps.arc;
in
{
  options.myconfig.apps.arc = {
    enable = mkEnableOption "arc";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ arc-browser ]; };
}
