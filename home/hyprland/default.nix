{
  lib,
  config,
  inputs,
  ...
}:

with lib;
let
  cfg = config.myconfig.hyprland;
in
{
  imports = [ ./wallpaper.nix ];

  options.myconfig.hyprland = {
    enable = mkEnableOption "hyprland";
    primary_monitor = mkOption {
      type = types.str;
      default = "";
      description = ''
        The code for the primary monitor.
      '';
    };
    secondary_monitor = mkOption {
      type = types.str;
      default = "";
      description = ''
        The code for the secondary monitor.
      '';
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd.enable = true;
      settings = {
        "$mod" = "SUPER";
        input = {
          touchpad.natural_scroll = true;
        };
        monitor = [
          "eDP-1,1920x1080@144,1920x0,1"
          "HDMI-A-1,1920x1080@60,0x0,1"
        ];
        workspace = [
          # Primary monitor
          "1, default:true, monitor:${cfg.primary_monitor}"
          "2, monitor:${cfg.primary_monitor}"
          "3, monitor:${cfg.primary_monitor}"
          "4, monitor:${cfg.primary_monitor}"
          "5, monitor:${cfg.primary_monitor}"
          "6, monitor:${cfg.primary_monitor}"
          # Second monitor
          "9, monitor:${cfg.secondary_monitor}, on-created-empty:[float] discord"
          "8, monitor:${cfg.secondary_monitor}, on-created-empty:[float] firefox"
          "7, monitor:${cfg.secondary_monitor}"
        ];
        bind =
          [
            "$mod, F, exec, firefox"
            "$mod, K, exec, kitty"
            "ALT, SPACE, exec, rofi -show drun"
            ", Print, exec, grimblast copy area"
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
            builtins.concatLists (
              builtins.genList (
                x:
                let
                  ws =
                    let
                      c = (x + 1) / 10;
                    in
                    builtins.toString (x + 1 - (c * 10));
                in
                [
                  "$mod, ${ws}, workspace, ${toString (x + 1)}"
                  "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                ]
              ) 10
            )
          );
      };
    };
  };
}
