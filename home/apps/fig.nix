{
  config,
  lib,
  inputs,
  ...
}:

with lib;
let
  cfg = config.myconfig.apps.fig;
in
{
  options.myconfig.apps.fig = {
    enable = mkEnableOption "fig";
  };

  config = mkIf cfg.enable { home.packages = with inputs; [ fig.packages.fig ]; };
}
