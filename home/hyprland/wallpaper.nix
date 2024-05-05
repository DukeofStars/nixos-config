{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  hypr-cfg = config.myconfig.hyprland;
  cfg = config.myconfig.hyprland.wallpaper;
in
{
  options.myconfig.hyprland.wallpaper = {
    enable = mkEnableOption "wallpapers with hyprpaper";
    wallpaper = mkOption {
      type = types.str;
      description = ''
        The file name of the picture to use. Path is expanded to ~/Pictures/{wallpaper}
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ hyprpaper ];
    home.file.".config/hypr/hyprpaper.conf".text = ''
      preload=~/Pictures/${cfg.wallpaper}
      wallpaper=${hypr-cfg.primaryMonitor},~/Pictures/${cfg.wallpaper}
      wallpaper=${hypr-cfg.secondaryMonitor},~/Pictures/${cfg.wallpaper}
      splash=false
    '';
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        # The wallpaper engine
        "hyprpaper"
      ];
    };
  };
}
