{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
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

    laptop.enable = true;
  };

  # Use Hyprland Cachix.
  # Hyprland is not on cache.nixos.org, so use an external cache instead.
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
        useOSProber = true;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "tristans-laptop"; # Define your hostname.
    # networkmanager.enable = true;
    wireless = {
      enable = true;
      userControlled.enable = true;
      networks."eduSTAR" = {
        hidden = true;
        auth = ''
          key_mgmt=WPA-EAP
          eap=PEAP
          phase2="auth=MSCHAPV2"
          identity="tdfox1@schools.vic.edu.au"
          password="MSC@xof3722"
        '';
      };
      networks."FoxHub-5G" = {
        pskRaw = "5360eb5a78406dc010a3a0af8e0be1dfe5fbf4e1fbd156ad5122a9692a4f5240";
      };
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

  environment = {
    variables = {
      XCURSOR_SIZE = "24";
      XDG_SESSION_TYPE = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    systemPackages = with pkgs; [
      git
      nano
      networkmanagerapplet
      rofi

      gnome.nautilus

      libsForQt5.qt5.qtgraphicaleffects

      protonup
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

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      # For hybrid graphics
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
      nvidiaSettings = true;
    };
  };

  #  users.mutableUsers = false;
  users.users.foxtristan = {
    isNormalUser = true;
    description = "Tristan Fox";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.nushell;
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

    displayManager.sddm = {
      enable = true;
      enableHidpi = true;
    };
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      libinput.mouse = {
        accelSpeed = "0";
        # flat: accelerate at a constant speed. adaptive: pointer acceleration depends on input speed.
        accelProfile = "flat";
      };
      # layout = "us";
      # xkbVariant = "colemak";
    };

    blueman.enable = true;
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 16 * 1024; # 16GB
    }
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
