{ config, lib, ... }:

with lib;
let cfg = config.myconfig.themes.catppuccin;
in {
  imports = [ ./gtk.nix ];
  options.myconfig.themes.catppuccin = {
    enable = mkEnableOption "catppuccin theme";
    flavour = mkOption {
      type = types.str;
      description = ''
        The flavour of catppuccin to use (latte, frappe, macchiato, mocha)
      '';
    };
    accent = mkOption {
      type = types.str;
      description = ''
        The accent colour to use
      '';
    };
  };
}