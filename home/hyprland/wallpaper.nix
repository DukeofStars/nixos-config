{
  config,
  lib,
  ...
}:

with lib;
let
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
    # services.hyprpaper = {
    #   enable = true;
    #   settings = {
    #     wallpaper = [
    #       ",~/Pictures/${cfg.wallpaper}"
    #     ];
    #   };
    # };
  };
}
