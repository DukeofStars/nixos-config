{ lib, config, ... }:

with lib;
let
  cfg = config.myconfig.hyprland;
in
{
  imports = [
    ./wallpaper.nix
    ./decoration.nix
  ];

  options.myconfig.hyprland = {
    enable = mkEnableOption "hyprland";
    primaryMonitor = mkOption {
      type = types.str;
      default = "";
      description = ''
        The code for the primary monitor.
      '';
    };
    secondaryMonitor = mkOption {
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
        general = {
          layout = "master";
        };
        input = {
          touchpad.natural_scroll = true;
          kb_variant = "colemak";
          accel_profile = "flat";
        };
        monitor = [
          "eDP-1,1920x1080@144,1920x0,1"
          "HDMI-A-1,1920x1080@60,0x0,1"
        ];
        workspace = [
          # Primary monitor
          "1, default:true, monitor:${cfg.primaryMonitor}"
          "2, monitor:${cfg.primaryMonitor}"
          "3, monitor:${cfg.primaryMonitor}"
          "4, monitor:${cfg.primaryMonitor}"
          "5, monitor:${cfg.primaryMonitor}"
          "6, monitor:${cfg.primaryMonitor}"
          # Second monitor
          "9, monitor:${cfg.secondaryMonitor}, on-created-empty:[float] nvidia-offload discord"
          "8, monitor:${cfg.secondaryMonitor}"
          "7, monitor:${cfg.secondaryMonitor}"
        ];
        bind =
          [
            (mkIf config.myconfig.apps.floorp.enable "$mod, F, exec, floorp")
            (mkIf config.myconfig.apps.kitty.enable "$mod, K, exec, kitty")
            (mkIf config.myconfig.apps.rofi.enable "ALT, SPACE, exec, rofi -show drun")
            ", Print, exec, grimblast copy area"
            "$mod, M, layoutmsg, swapwithmaster"
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
