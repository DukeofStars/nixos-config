{ config, lib, ... }:

with lib;
let
  cfg = config.myconfig.server;
in
{
  options.myconfig.server = {
    enable = mkEnableOption "server";
  };

  config = mkIf cfg.enable {
    nix.settings = {
      # Use Hyprland cache server.
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      # Enable experimental features
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };

    # Bootloader.
    boot = {
      loader = {
        #systemd-boot.enable = true;
        grub = {
          enable = true;
          devices = [ "nodev" ];
          efiSupport = true;
          useOSProber = false;
        };
        efi.canTouchEfiVariables = true;
      };
    };

    networking.wireless = {
      enable = true;
      userControlled.enable = true;
      networks."FoxHub-5G" = {
        pskRaw = "5360eb5a78406dc010a3a0af8e0be1dfe5fbf4e1fbd156ad5122a9692a4f5240";
      };
    };
    # Set your time zone.
    time = {
      timeZone = "Australia/Melbourne";
      hardwareClockInLocalTime = true;
    };

    # Select internationalisation properties.
    i18n = {
      defaultLocale = "en_AU.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "en_AU.UTF-8";
        LC_IDENTIFICATION = "en_AU.UTF-8";
        LC_MEASUREMENT = "en_AU.UTF-8";
        LC_MONETARY = "en_AU.UTF-8";
        LC_NAME = "en_AU.UTF-8";
        LC_NUMERIC = "en_AU.UTF-8";
        LC_PAPER = "en_AU.UTF-8";
        LC_TELEPHONE = "en_AU.UTF-8";
        LC_TIME = "en_AU.UTF-8";
      };
    };

    environment.systemPackages = with pkgs; [
      git
      nano
      helix
    ];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    services = {
      # Enable the OpenSSH daemon.
      openssh.enable = true;

      # Enable CUPS to print documents.
      printing.enable = true;
    };
  };
}