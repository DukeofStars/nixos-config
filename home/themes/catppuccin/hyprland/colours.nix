# Load the catppuccin colours, from the catppuccin/hyprland repository.

{ config, lib, inputs, ... }:

with lib;
let cfg = config.myconfig.themes.catppuccin;
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      source =
        [ "${inputs.catppuccin-hyprland-colours}/themes/${cfg.flavour}.conf" ];
    };
  };
}
