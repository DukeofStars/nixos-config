{ config, lib, ... }:

with lib;
let
  cfg = config.myconfig.apps.thunderbird;
in
{
  options.myconfig.apps.thunderbird = {
    enable = mkEnableOption "thunderbird";
  };

  config = mkIf cfg.enable {
    programs.thunderbird = {
      enable = true;
      profiles = {
        default = {
          isDefault = true;
        };
      };
    };
  };
}
