{ config, pkgs, ... }:

let enabled = { enable = true; };
in {
  imports = [ ./apps ./hyprland ./services ./themes ./fonts.nix ];

  myconfig = {
    themes.catppuccin = {
      enable = true;
      flavour = "mocha";
      accent = "blue";
    };
    apps = {
      rofi = enabled;
      waybar = enabled;
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

  # Cursor
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-Classic";
    size = 24;
    package = pkgs.bibata-cursors;
  };

  # Hyprland
  home.sessionVariables = { XCURSOR_SIZE = 24; };

  home.packages = with pkgs; [
    # Obviously.
    home-manager

    # Text editor
    kate

    # Discord, with OpenAsar
    (discord.override { withOpenASAR = true; })
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

  home.file.".config/jj/config.toml".text = ''
    [ui]
    paginate = "never"

    [user]
    name = "Tristan Fox"
    email = "foxtristan@proton.me"
  '';
}
