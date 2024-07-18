{ config, lib, ... }:

with lib;
let
  cfg = config.myconfig.hyprland.wallpaper;
in
{
  options.myconfig.hyprland.wallpaper = {
    enable = mkEnableOption "wallpapers with hyprpaper";
    path = mkOption {
      type = types.path;
      description = ''
        The file name of the picture to use.
      '';
    };
  };

  config = mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        wallpaper = [ ",${cfg.path}" ];
      };
    };
  };
}
