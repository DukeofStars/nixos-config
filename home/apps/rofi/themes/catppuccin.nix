{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with types;
let
  cfg = config.myconfig.apps.rofi.themes.catppuccin;
  pkg = pkgs.stdenv.mkDerivation {
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
      sha256 = "sha256-zA8Zum19pDTgn0KdQ0gD2kqCOXK4OCHBidFpGwrJOqg=";
      rev = "main";
    };
  };
in
{
  options.myconfig.apps.rofi.themes.catppuccin = {
    enable = mkEnableOption "catppuccin-rofi-theme";
    flavour = mkOption { type = uniq str; };
  };
  config = mkIf cfg.enable {
    programs.rofi = {
      theme = lib.mkForce "${pkg}/share/rofi/themes/catppuccin-${cfg.flavour}";
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
