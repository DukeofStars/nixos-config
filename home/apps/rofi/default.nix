{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.myconfig.apps.rofi;
in
{
  imports = [ ./themes/catppuccin.nix ];

  options.myconfig.apps.rofi = {
    enable = mkEnableOption "rofi";
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      terminal = "kitty";
    };
  };
}
