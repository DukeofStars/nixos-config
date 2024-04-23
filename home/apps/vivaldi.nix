{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.myconfig.apps.vivaldi;
in
{
  options.myconfig.apps.vivaldi = {
    enable = mkEnableOption "Vivaldi browser";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (vivaldi.override {
        proprietaryCodecs = true;
        enableWidevine = false;
      })
      vivaldi-ffmpeg-codecs
      vivaldi-widevine
    ];
  };
}
