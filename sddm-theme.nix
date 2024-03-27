{ stdenv, fetchzip, ... }:
{
  catppuccin-mocha = stdenv.mkDerivation rec {
    pname = "sddm-catppuccin-mocha-theme";
    version = "1.0";
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
}
