{ pkgs, ... }:

{
  config = {
    environment.etc."greetd/hyprland.conf".text = ''
      exec-once=${pkgs.greetd.regreet}/bin/regreet; hyprctl dispatch exit
      input = {
          touchpad.natural_scroll = true;
          kb_variant = "colemak";
          accel_profile = "flat";
          scroll_factor = 0.7;
      }
    '';
    services.greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = "Hyprland";
          user = "foxtristan";
        };
        default_session = {
          command = "Hyprland --config /etc/greetd/hyprland.conf";
          user = "greeter";
        };
        terminal = {
          vt = 1;
        };
      };
    };
    security.pam.services.hyprlock = { };
    programs.regreet = {
      enable = true;
    };
  };
}
