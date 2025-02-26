{
  config,
  lib,
  inputs,
  ...
}:

with lib;
let
  cfg = config.myconfig.apps.zen;
in
{
  imports = [ ];

  options.myconfig.apps.zen = {
    enable = mkEnableOption "zen";
  };

  config = mkIf cfg.enable { home.packages = [ inputs.zen-browser.packages.x86_64-linux.specific ]; };
}
