{ config, lib, ... }:

with lib;
let
  cfg = config.myconfig.tailscale;
in
{
  options.myconfig.tailscale = {
    enable = mkEnableOption "tailscale";
  };

  config = mkIf cfg.enable { services.tailscale.enable = true; };
}
