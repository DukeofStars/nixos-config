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
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          output = [
            "eDP-1"
            "HDMI-A-1"
          ];
          modules-left = [
            "hyprland/workspaces"
            "hyprland/window"
          ];
          modules-center = [ "clock" ];
          modules-right = [
            "battery"
            "temperature"
            "wlr/taskbar"
          ];
          "clock" = {
            "format" = "{:%H:%M:%S}  ";
            "format-alt" = "{:%A; %B %d; %Y (%R)}  ";
            "tooltip-format" = "<tt><small>{calendar}</small></tt>";
            "calendar" = {
              "mode" = "year";
              "mode-mon-col" = 3;
              "weeks-pos" = "right";
              "on-scroll" = 1;
              "format" = {
                "months" = "<span color='#ffead3'><b>{}</b></span>";
                "days" = "<span color='#ecc6d9'><b>{}</b></span>";
                "weeks" = "<span color='#99ffdd'><b>W{}</b></span>";
                "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
                "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
              };
              # "actions" = {
              #   "on-click-right" = "mode";
              #   "on-scroll-up" = "tz_up";
              #   "on-scroll-down" = "tz_down";
              #   "on-scroll-up" = "shift_up";
              #   "on-scroll-down" = "shift_down";
              # };
            };
          };
        };
      };
    };
    wayland.windowManager.hyprland.settings = {
      exec-once = [ "waybar" ];
    };
  };
}
