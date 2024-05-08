{
  config,
  lib,
  pkgs,
  fetchzip,
  ...
}:
with lib;
let
  cfg = config.myconfig.themes.sddm;
  sddm-themes = {
    catppuccin-mocha = pkgs.stdenv.mkDerivation rec {
      pname = "sddm-catppuccin-mocha-theme";
      version = "1.1";
      dontBuild = true;
      installPhase = ''
        mkdir -p $out/share/sddm/themes
        cp -aR $src $out/share/sddm/themes/catppuccin-mocha
      '';
      src = fetchzip {
        url = "https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-mocha.zip";
        hash = "sha256-+YxKzuu2p46QoCZykXLYFwkXcJ+uJ7scwDU7vJ4b1pA=";
      };
    };
    sugar-dark = pkgs.stdenv.mkDerivation rec {
      pname = "sddm-sugar-dark-theme";
      version = "1.2";
      dontBuild = true;
      installPhase = ''
        mkdir -p $out/share/sddm/themes
        cp -aR $src $out/share/sddm/themes/sugar-dark
      '';
      src = pkgs.fetchFromGitHub {
        owner = "MarianArlt";
        repo = "sddm-sugar-dark";
        rev = "v${version}";
        sha256 = "0gx0am7vq1ywaw2rm1p015x90b75ccqxnb1sz3wy8yjl27v82yhb";
      };
    };
  };
in
{
  options.myconfig.themes.sddm = {
    enable = mkEnableOption "SDDM theming";
    theme = mkOption {
      type = types.str;
      description = ''
        The theme to use.
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ sddm-themes.${cfg.theme} ];
    services.displayManager.sddm = {
      theme = cfg.theme;
    };
  };
}
