{ config, lib, ... }:

with lib;
let
  cfg = config.myconfig.apps.waybar;
in
{
  options.myconfig.apps.waybar = {
    enable = mkEnableOption "waybar";
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;
    };
    wayland.windowManager.hyprland.settings = {
      exec-once = [ "waybar" ];
    };
  };
}
