{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.myconfig.themes.catppuccin;
  firstLetterToUpper =
    x:
    strings.concatImapStrings (i: e: if i == 1 then (strings.toUpper e) else e) (
      strings.stringToCharacters x
    );
in
{
  config = mkIf cfg.enable {
    gtk = {
      theme = {
        name = "Catppuccin-${firstLetterToUpper cfg.flavour}-Standard-${firstLetterToUpper cfg.accent}-Dark";
        package = pkgs.catppuccin-gtk.override {
          variant = cfg.flavour;
          size = "standard";
          accents = [ cfg.accent ];
        };
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-folders;
      };
    };
    xdg.configFile = {
      "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
      "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    };
  };
}
