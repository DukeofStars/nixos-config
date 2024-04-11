{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.myconfig.services.dunst;
in
{
  options.myconfig.services.dunst = {
    enable = mkEnableOption "dunst";
  };

  config = mkIf cfg.enable {
    services.dunst = {
      enable = true;
    };
  };
}
