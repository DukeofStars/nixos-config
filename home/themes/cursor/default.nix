{ lib, config, ... }:

with lib;
let cfg = config.myconfig.themes.cursor;
in {
  options.myconfig.themes.cursor = {
    enable = mkEnableOption "cursor themes";
    package = mkOption {
      type = types.package;
      description = "Cursor package to use";
    };
    size = mkOption {
      type = types.number;
      description = "Cursor size to use";
    };
    name = mkOption {
      type = types.str;
      description = "Cursor name to use";
    };
  };

  config = mkIf cfg.enable {
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = cfg.name;
      size = cfg.size;
      package = cfg.package;
    };

    home.sessionVariables = { XCURSOR_SIZE = cfg.size; };
  };
}
