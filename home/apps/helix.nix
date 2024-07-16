{ config, lib, ... }:

with lib;
let
  cfg = config.myconfig.apps.helix;
in
{
  options.myconfig.apps.helix = {
    enable = mkEnableOption "helix";
  };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      settings = {
        keys.normal = {
          n = "move_char_left";
          e = "move_line_down";
          i = "move_line_up";
          o = "move_char_right";

          u = "insert_mode";
        };
        editor.cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
  };
}
