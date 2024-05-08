{
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.myconfig.apps.helix;
in
{
  options.myconfig.apps.helix = {
    enable = mkEnableOption "helix";
  };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
    };
  };
}
