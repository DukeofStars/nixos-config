{ config, pkgs, inputs, lib, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../themes
    ../../modules
  ];

  myconfig = {
    steam.enable = true;
    themes.sddm = {
      enable = true;
      theme = "sugar-dark";
    };
  };

  # Use Hyprland Cachix.
  # Hyprland is not on cache.nixos.org, so use an external cache instead.
  nix.settings = {
    # Use Hyprland cache server.
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys =
      [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    # Enable experimental features
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    #     wireless = {
    #       enable = true;  # Enables wireless support via wpa_supplicant.
    #       userControlled.enable = true;
    #     };
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

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

  environment = {
    variables = {
      XCURSOR_SIZE = "24";
      LIBVA_DRIVER_NAME = "nvidia";
      XDG_SESSION_TYPE = "wayland";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      WLR_NO_HARDWARE_CURSORS = "1";
    };
    sessionVariables = { NIXOS_OZONE_WL = "1"; };
    systemPackages = with pkgs; [
      git
      nano
      networkmanagerapplet
      rofi

      gnome.nautilus

      libsForQt5.qt5.qtgraphicaleffects
    ];
  };

  programs.hyprland.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  sound.mediaKeys.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth = { enable = true; };

  users.users.foxtristan = {
    isNormalUser = true;
    description = "Tristan Fox";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services = {
    # Enable Nautilus File Manager (https://nixos.wiki/wiki/Nautilus)
    gvfs.enable = true;

    # Enable the OpenSSH daemon.
    openssh.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;

    xserver = {
      enable = true;
      displayManager.sddm = {
        enable = true;
        enableHidpi = true;
      };
      libinput.mouse = {
        accelSpeed = "0";
        # flat: accelerate at a constant speed. adaptive: pointer acceleration depends on input speed.
        accelProfile = "flat";
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}