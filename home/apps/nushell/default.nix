{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with lib;
let
  cfg = config.myconfig.apps.nushell;
in
{
  options.myconfig.apps.nushell = {
    enable = mkEnableOption "nushell";
  };

  config = mkIf cfg.enable {
    programs.nushell = {
      enable = true;
      configFile.source = ./config.nu;
      envFile.source = ./env.nu;
    };
    # Nushell configuration uses starship.
    myconfig.apps.starship.enable = true;
  };
}
