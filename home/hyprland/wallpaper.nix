{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.myconfig.hyprland.wallpaper;
{
  options.myconfig.hyprland.wallpaper = {
    enable = mkEnableOption = "wallpapers with hyprpaper";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprpaper
    ];
    home.file.".config/hypr/hyprpaper.conf".text = ''
      preload=~/Pictures/${wallpaper}
      wallpaper=${primary_monitor},~/Pictures/${wallpaper}
      wallpaper=${secondary_monitor},~/Pictures/${wallpaper}
      splash=false
    '';
    wayland.windowManager.hyprland = {
      exec-once = [
        # The wallpaper engine
        "hyprpaper"
      ];
    };
  };
}
