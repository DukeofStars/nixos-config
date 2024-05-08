{ config, lib, ... }:

with lib;
let
  cfg = config.myconfig.themes.catppuccin;
in
{
  config = mkIf cfg.enable {
    programs.helix.settings.theme = "catppuccin_${cfg.flavour}";
    };
}
