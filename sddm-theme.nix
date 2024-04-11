{ stdenv, fetchzip, fetchFromGitHub, ... }:
{
  catppuccin-mocha = stdenv.mkDerivation rec {
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
  sugar-dark = stdenv.mkDerivation rec {
    pname = "sddm-sugar-dark-theme";
    version = "1.2";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/sugar-dark
    '';
    src = fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-sugar-dark";
      rev = "v${version}";
      sha256 = "0gx0am7vq1ywaw2rm1p015x90b75ccqxnb1sz3wy8yjl27v82yhb";
    };
  };
}
