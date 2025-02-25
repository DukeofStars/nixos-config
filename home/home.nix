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
    ./fonts.nix
  ];

  myconfig = {
    apps = {
      rofi = {
        enable = true;
        themes.catppuccin = {
          enable = true;
          flavour = "mocha";
        };
      };
      ags = enabled;
      kitty = enabled;
      nushell = enabled;
      # Implied by 'nushell = enabled', but here for clarity.
      starship = enabled;
      thunderbird = enabled;
      webex = enabled;
      helix = enabled;
      floorp = enabled;
      zen = enabled;
      fig = enabled;
      spotify = enabled;
    };
    hyprland = {
      enable = true;
      primaryMonitor = "HDMI-A-1";
      secondaryMonitor = "eDP-1";
      # wallpaper = {
      #   enable = true;
      #   path = ../.wallpapers/gruvbox/Fighters.png;
      # };
    };
    services = { };
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
    libreoffice-qt6
  
    # Obviously.
    home-manager

    # Zoxide (https://github.com/ajeetdsouza/zoxide)
    zoxide

    # Nix language server
    nil

    # Discord, with OpenAsar
    discord

    # Of course.
    neofetch

    # I think this is a screenshot tool.
    grimblast

    # For viewing images.
    gwenview

    # Typst
    typst
    typst-lsp
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      let
        defaultBrowser = "floorp.desktop";
      in
      {
        "image/png" = [ "gwenview.desktop" ];
        "image/jpeg" = [ "gwenview.desktop" ];
        "inode/directory" = [ "nautilus.desktop" ];
        "text/html" = defaultBrowser;
        "x-scheme-handler/http" = defaultBrowser;
        "x-scheme-handler/https" = defaultBrowser;
        "x-scheme-handler/about" = defaultBrowser;
        "x-scheme-handler/unknown" = defaultBrowser;
      };
  };

  programs = {
    home-manager = enabled;
    firefox = enabled;
    alacritty = enabled;
    rofi = enabled;
    neovim = enabled;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };
}
