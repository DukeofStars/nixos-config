{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.myconfig.apps.webex;
in
{
  options.myconfig.apps.webex = {
    enable = mkEnableOption "webex";
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ webex ]; };
}
