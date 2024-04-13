{ config, lib, ... }:

with lib;
let
  cfg = config.myconfig.themes.catppuccin;
  firstLetterToUpper = x:
    strings.concatImapStrings (i: e: if i == 1 then (strings.toUpper e) else e)
    (strings.stringToCharacters x);
in {
  config = mkIf cfg.enable {
    programs.kitty = {
      theme = "Catppuccin-${firstLetterToUpper cfg.flavour}";
    };
  };
}
