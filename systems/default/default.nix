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

    laptop.enable = true;
  };

  virtualisation.docker = {
    enable = true;
  };

  xdg = {
    portal = {
      enable = true;
      config = {
        common = {
          "org.freedesktop.portal.FileChooser" = "gtk";
        };
      };
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };
  };

  stylix = {
    enable = true;
    image = ../../.wallpapers/gruvbox/Jellyfish-Astronaut-Soft.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
    cursor = {
      size = 32;
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
    };
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
        name = "JetBrainsMono Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };

  # Use Hyprland Cachix.
  # Hyprland is not on cache.nixos.org, so use an external cache instead.
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
    settings = {
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
    supportedFilesystems = [ "ntfs" ];
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
      networks."tristans_iphone" = {
        pskRaw = "309c21878268e8ae7c64b1c3d733ab39dc55f961f8b66da1939ceba1b462451c";
      };
      networks."OPTUS_8974AE_MESH" = {
        pskRaw = "9f24875fa8e6f27b743dc67d2c42eec34dfa4c913ac529dfdafdb6f471dd7b26";
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

  # console.keyMap = "colemak/en-latin9";

  environment = {
    variables = {
      XDG_SESSION_TYPE = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      DEFAULT_BROWSER = "${pkgs.floorp}/bin/floorp";
    };
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    systemPackages = with pkgs; [
      git
      rofi

      nautilus

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
    wireplumber.extraConfig = {
      # Source: https://wiki.archlinux.org/title/bluetooth_headset#Disable_PulseAudio_auto_switching_headset_to_HSP
      "wireplumber.settings" = {
        ## Whether to use headset profile in the presence of an input stream.
        "bluetooth.autoswitch-to-headset-profile" = false;
      };
      "monitor.bluez.properties" = {
        ## Enabled roles (default: [ a2dp_sink a2dp_source bap_sink bap_source hfp_hf hfp_ag ])
        ##
        ## Currently some headsets (Sony WH-1000XM3) are not working with
        ## both hsp_ag and hfp_ag enabled, so by default we enable only HFP.
        ##
        ## Supported roles: hsp_hs (HSP Headset),
        ##                  hsp_ag (HSP Audio Gateway),
        ##                  hfp_hf (HFP Hands-Free),
        ##                  hfp_ag (HFP Audio Gateway)
        ##                  a2dp_sink (A2DP Audio Sink)
        ##                  a2dp_source (A2DP Audio Source)
        ##                  bap_sink (LE Audio Basic Audio Profile Sink)
        ##                  bap_source (LE Audio Basic Audio Profile Source)
        ## --
        ## Only enable A2DP here and disable HFP. See note at the top as to why.
        "bluez5.roles" = [
          "a2dp_sink"
          "a2dp_source"
        ];
      };
    };
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
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    # opengl = {
    #   enable = true;
    #   driSupport = true;
    #   driSupport32Bit = true;
    # };
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
      "docker"
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

    libinput.mouse = {
      accelSpeed = "0";
      # flat: accelerate at a constant speed. adaptive: pointer acceleration depends on input speed.
      accelProfile = "flat";
    };

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      xkb.variant = "colemak,";
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
