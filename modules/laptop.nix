{ config, lib, ... }:

with lib;
let
  cfg = config.myconfig.laptop;
in
{
  options.myconfig.laptop = {
    enable = mkEnableOption "laptop sensible configuration options";
  };

  config = mkIf cfg.enable {
    powerManagement.enable = true;
    services = {
      # I don't really know which one is best, so just enable them all!

      thermald.enable = true;
      tlp.enable = true;
    };
  };
}
