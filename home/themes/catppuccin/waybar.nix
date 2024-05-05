{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.myconfig.themes.catppuccin;
  style-pkg = pkgs.stdenv.mkDerivation rec {
    pname = "catppuccin-waybar-theme";
    version = "1.0.0";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/
      cp -aR $src/themes/* $out/
    '';
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "waybar";
      sha256 = "sha256-9lY+v1CTbpw2lREG/h65mLLw5KuT8OJdEPOb+NNC6Fo=";
      rev = "main";
    };
  };
in
{
  config = mkIf cfg.enable {
    programs.waybar = {
      # Shamelessly stolen from i4pg (https://github.com/i4pg/dotfiles)
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          output = [
            "${config.myconfig.hyprland.primaryMonitor}"
            "${config.myconfig.hyprland.secondaryMonitor}"
          ];

          modules-left = [
            "custom/launcher"
            "hyprland/workspaces"
            "custom/scratchpad-indicator"
            "temperature"
            "pulseaudio"
            "idle_inhibitor"
            "mpd"
            "custom/cava-internal"
          ];
          modules-center = [
            "custom/weather"
            "clock"
          ];
          modules-right = [
            "backlight"
            "disk"
            "memory"
            "cpu"
            "battery"
            "tray"
            "custom/powermenu"
          ];
          "custom/launcher" = {
            format = "";
            on-click = "rofi -show drun";
          };
          "idle_inhibitor" = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
            tooltip = false;
          };
          "disk" = {
            interval = 30;
            format = " {used}";
            path = "/home";
            tooltip = true;
            tooltip-format = "{used}/{total} => {path} {percentage_used}%";
          };
          "pulseaudio" = {
            scroll-step = 1;
            format = "{icon} {volume}%";
            format-muted = "婢 Muted";
            format-icons = {
              default = [
                ""
                ""
                ""
              ];
            };
            on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
            tooltip = false;
          };
          "battery" = {
            interval = 10;
            states = {
              warning = 20;
              critical = 10;
            };
            format = "{icon} {capacity}%";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
              ""
            ];
            format-full = "{icon} {capacity}%";
            format-charging = " {capacity}%";
            tooltip = true;
          };
          "clock" = {
            on-clic = "~/.config/waybar/to_latte.sh &";
            on-click-righ = "~/.config/waybar/wallpaper_random.sh &";
            on-click-middl = "~/.config/waybar/live_wallpaper.sh &";
            interva = 1;
            forma = "{:%I:%M %p  %A %b %d}";
            toolti = true;
            tooltip-forma = ''
              {:%A, %d %B %Y}
              <tt>{calendar}</tt>'';
          };
          "memory" = {
            on-click = "kitty btm";
            interval = 1;
            format = "﬙ {percentage}%";
            states = {
              "warning" = 85;
            };
          };
          "cpu" = {
            interval = 1;
            format = " {usage}%";
          };
          "mpd" = {
            max-length = 25;
            format = "<span foreground='#bb9af7'></span> {title}";
            format-paused = " {title}";
            format-stopped = "<span foreground='#bb9af7'></span>";
            format-disconnected = "";
            on-click = "mpc --quiet toggle";
            on-click-right = "mpc ls | mpc add";
            on-click-middle = "kitty ncmpcpp";
            on-scroll-up = "mpc --quiet prev";
            on-scroll-down = "mpc --quiet next";
            smooth-scrolling-threshold = 5;
            tooltip-format = "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
          };
          "network" = {
            interval = 1;
            format-wifi = "說 {essid}";
            format-ethernet = "  {ifname} ({ipaddr})";
            format-linked = "說 {essid} (No IP)";
            format-disconnected = "說 Disconnected";
            tooltip = false;
          };
          "temperature" = {
            hwmon-path = "/sys/class/hwmon/hwmon4/temp2_input";
            critical-threshold = 80;
            tooltip = false;
            format = " {temperatureC}°C";
          };
          "custom/powermenu" = {
            format = "";
            on-click = "~/.config/rofi/powermenu.sh";
            tooltip = false;
          };
          "tray" = {
            icon-size = 15;
            spacing = 5;
          };
          "custom/weather" = {
            format = "{}";
            tooltip = true;
            interval = 3600;
            exec = "~/.config/waybar/wabar-wttr.py";
            return-type = "json";
          };
        };
      };
      style = ''
        @import "${style-pkg}/${cfg.flavour}.css";

        /* Global */
        * {
          font-family: "FiraCode Nerd Font";
          font-size: .9rem;
          border-radius: 1rem;
          transition-property: background-color;
          transition-duration: 0.5s;
          background-color: shade(@base, 0.9);
        }

        @keyframes blink_red {
          to {
            background-color: @red;
            color: @base;
          }
        }

        .warning, .critical, .urgent {
          animation-name: blink_red;
          animation-duration: 1s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
        }

        #mode, #clock, #memory, #temperature, #cpu, #custom-weather,
        #mpd, #idle_inhibitor, #backlight, #pulseaudio, #network, 
        #battery, #custom-powermenu, #custom-cava-internal,
        #custom-launcher, #tray, #disk, #custom-pacman, #custom-scratchpad-indicator {
          padding-left: .6rem;
          padding-right: .6rem;
        }

        /* Bar */
        window#waybar {
          background-color: transparent;
        }

        window > box {
          background-color: transparent;
          margin: .3rem;
          margin-bottom: 0;
        }


        /* Workspaces */
        #workspaces:hover {
          background-color: @green;
        }

        #workspaces button {
          padding-right: .4rem;
          padding-left: .4rem;
          padding-top: .1rem;
          padding-bottom: .1rem;
          color: @red;
          /* border: .2px solid transparent; */
          background: transparent;
        }

        #workspaces button.focused {
          color: @blue;
        }

        #workspaces button:hover {
          /* border: .2px solid transparent; */
          color: @rosewater;
        }

        /* Tooltip */
        tooltip {
          background-color: @base;
        }

        tooltip label {
          color: @rosewater;
        }

        /* battery */
        #battery {
          color: @mauve;
        }
        #battery.full {
          color: @green;
        }
        #battery.charging{
          color: @teal;
        }
        #battery.discharging {
          color: @peach;
        }
        #battery.critical:not(.charging) {
          color: @pink;
        }
        #custom-powermenu {
          color: @red;
        }

        /* mpd */
        #mpd.paused {
          color: @pink;
          font-style: italic;
        }
        #mpd.stopped {
          color: @rosewater;
          /* background: transparent; */
        }
        #mpd {
          color: @lavender;
        }

        /* Extra */
        #custom-cava-internal{
          color: @peach;
          padding-right: 1rem;
        }
        #custom-launcher {
          color: @yellow;
        }
        #memory {
          color: @peach;
        }
        #cpu {
          color: @blue;
        }
        #clock {
          color: @rosewater;
        }
        #idle_inhibitor {
          color: @green;
        }
        #temperature {
          color: @sapphire;
        }
        #backlight {
          color: @green;
        }
        #pulseaudio {
          color: @mauve;  /* not active */
        }
        #network {
          color: @pink; /* not active */
        }
        #network.disconnected {
          color: @foreground;  /* not active */
        }
        #disk {
          color: @maroon;
        }
        #custom-pacman{
          color: @sky;
        }
        #custom-scratchpad-indicator {
          color: @yellow
        }
        #custom-weather {
          color: @red;
        }
      '';
    };
  };
}
