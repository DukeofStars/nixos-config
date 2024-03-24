{ config, pkgs, ... }:

let
  primary_monitor = "HDMI-A-1";
  secondary_monitor = "eDP-1";
in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "foxtristan";
  home.homeDirectory = "/home/foxtristan";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Hyprland
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
        "1, default:true, monitor:${primary_monitor}"
        "2, monitor:${primary_monitor}"
        "3, monitor:${primary_monitor}"
        "4, monitor:${primary_monitor}"
        "5, monitor:${primary_monitor}"
        "6, monitor:${primary_monitor}"
        # Second monitor
        "9, monitor:${secondary_monitor}, on-created-empty:[float] discord"
        "8, monitor:${secondary_monitor}, on-created-empty:[float] firefox"
        "7, monitor:${secondary_monitor}"
      ];
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "XDG_SESSION_TYPE,wayland"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "WLR_NO_HARDWARE_CURSORS,1"
      ];
      bind =
        [
          "$mod, F, exec, firefox"
          "$mod, K, exec, alacritty"
          "ALT, SPACE, exec, rofi -show run"
          ", Print, exec, grimblast copy area"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
      };
  };

  home.packages = with pkgs; [
    # Obviously.
    home-manager

    # Text editor
    kate

    # Discord, with OpenAsar
    (discord.override {
      withOpenASAR = true;
    })
    # For screensharing.
    vesktop

    # Better git client
    jujutsu

    # Of course.
    neofetch

    # I think this is a screenshot tool.
    grimblast

    # Alacritty terminal
    alacritty
  ];

  programs = {
    home-manager.enable = true;
    firefox.enable = true;
    alacritty.enable = true;
    rofi.enable = true;
    neovim.enable = true;
  };

  home.file.".config/jj/config.toml".text = ''
[ui]
paginate = "never"

[user]
name = "Tristan Fox"
email = "foxtristan@proton.me"
'';
}
