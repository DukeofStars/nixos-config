{
  config,
  lib,
  inputs,
  ...
}:

with lib;
let
  cfg = config.myconfig.apps.ags;
in
{
  options.myconfig.apps.ags = {
    enable = mkEnableOption "ags";
  };

  config = mkIf cfg.enable {
    home.packages = [ inputs.ags.packages.ags ];
    wayland.windowManager.hyprland.settings = {
      exec-once = [ "${inputs.ags.packages.ags}/bin/ags" ];
    };
  };
}
