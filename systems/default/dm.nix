{ pkgs, ... }:

{
  config = {
    environment.etc."greetd/hyprland.conf".text = "exec-once=${pkgs.greetd.regreet}/bin/regreet; hyprctl dispatch exit";
    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "Hyprland --config /etc/greetd/hyprland.conf";
      };
    };
    programs.regreet = {
      enable = true;
    };
  };
}
