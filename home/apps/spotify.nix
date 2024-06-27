{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.myconfig.apps.spotify;
in
{
  options.myconfig.apps.spotify = {
    enable = mkEnableOption "spotify";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      spotify
    ];
  };
}
