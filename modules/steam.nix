{
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.myconfig.steam;
in
{
  options.myconfig.steam = {
    enable = mkEnableOption "steam";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;
    };
    programs.gamemode.enable = true;
  };
}
