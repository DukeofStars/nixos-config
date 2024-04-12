{ config, lib, pkgs, ... }:

with lib;
let cfg = config.myconfig.apps.rofi;
in {
  options.myconfig.apps.rofi = { enable = mkEnableOption "rofi"; };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      terminal = "alacritty";
    };
  };
}
