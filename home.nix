{ config, pkgs, ... }:

{
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
    (discord.override {
      withOpenASAR = true;
    })

    # Better git client
    jujutsu
  ];

  programs = {
    home-manager.enable = true;
    firefox.enable = true;
  };
}
