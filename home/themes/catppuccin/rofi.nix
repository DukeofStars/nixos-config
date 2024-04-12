{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.myconfig.themes.catppuccin;
  pkg = pkgs.stdenv.mkDerivation rec {
    pname = "catppuccin-rofi-theme";
    version = "1.0.2";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/rofi/themes
      cp -aR $src/basic/.local/* $out/
    '';
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "rofi";
      sha256 = "sha256-DNorfyl3C4RBclF2KDgwvQQwixpTwSRu7fIvihPN8JY=";
      rev = "main";
    };
  };
in {
  config = mkIf cfg.enable {
    programs.rofi = {
      theme = "${pkg}/share/rofi/themes/catppuccin-${cfg.flavour}";
      extraConfig = {
        modi = "run,drun,window";
        icon-theme = "Oranchelo";
        show-icons = true;
        drun-display-format = "{icon} {name}";
        location = 0;
        disable-history = false;
        hide-scrollbar = true;
        display-drun = "   Apps ";
        display-run = "   Run ";
        display-window = " 﩯  Window";
        display-Network = " 󰤨  Network";
        sidebar-mode = true;
      };
    };
    home.packages = [ pkg ];
  };
}
