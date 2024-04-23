{ pkgs, ... }:

let
  enabled = {
    enable = true;
  };
in
{
  imports = [
    ./apps
    ./hyprland
    ./services
    ./themes
    ./fonts.nix
  ];

  myconfig = {
    themes.catppuccin = {
      enable = true;
      flavour = "mocha";
      accent = "blue";
    };
    themes.cursor = {
      enable = true;
      size = 28;
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
    };
    apps = {
      rust = enabled;
      rofi = enabled;
      waybar = enabled;
      kitty = enabled;
      nushell = enabled;
      # Implied by 'nushell = enabled', but here for clarity.
      starship = enabled;
      thunderbird = enabled;
      vivaldi = enabled;
    };
    hyprland = {
      enable = true;
      primary_monitor = "HDMI-A-1";
      secondary_monitor = "eDP-1";
      wallpaper = {
        enable = true;
        wallpaper = "sakuratree.png";
      };
    };
    services = {
      dunst = enabled;
    };
  };

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

  home.packages = with pkgs; [
    # Obviously.
    home-manager

    # Text editor
    kate

    # Discord, with OpenAsar
    (discord.override { withOpenASAR = true; })

    # Of course.
    neofetch

    # I think this is a screenshot tool.
    grimblast

    # For viewing images.
    gwenview

    # VSCodium (with easy extension management)
    vscodium-fhs
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = [ "gwenview.desktop" ];
      "image/jpeg" = [ "gwenview.desktop" ];
      "inode/directory" = [ "nautilus.desktop" ];
    };
  };

  programs = {
    home-manager = enabled;
    firefox = enabled;
    alacritty = enabled;
    rofi = enabled;
    neovim = enabled;
  };

  gtk.enable = true;
}
