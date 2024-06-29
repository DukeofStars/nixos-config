{ config, lib, ... }:

with lib;
let
  cfg = config.myconfig.themes.catppuccin;
in
{
  imports = [ ];
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        # "col.active_border" = "\$${cfg.accent}";
        # "col.inactive_border" = "$surface0";
      };
      decoration = {
        rounding = 6;
      };
      animations = {
        enabled = "yes";
        bezier = [ "myBezier, 0.05, 0.9, 0.1, 1.05" ];
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        new_is_master = false;
      };
    };
  };
}
