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
      settings.default_session = {
        command = "Hyprland --config /etc/greetd/hyprland.conf";
      };
    };
    programs.regreet = {
      enable = true;
    };
  };
}
