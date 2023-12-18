{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ./unstable.nix
    ];

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1v"
    "openssl-1.1.1w"
    "electron-24.8.6"
  ];

  # set to auto run garbage collection
  nix.settings.auto-optimise-store = true;

  # allow unfree stuff
  nixpkgs.config.allowUnfree = true;

  # docker
  virtualisation.docker.enable = true;
  virtualisation.docker.liveRestore = false;

  # libvirt
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # flatpak
  services.flatpak.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking config
  networking.hostName = "nixos";
  networking.domain = "lan";

  # this is for a custom dns
  networking.nameservers = [ "172.30.0.3" ];
  networking.resolvconf.enable = pkgs.lib.mkForce false;
  networking.dhcpcd.extraConfig = "nohook resolv.conf";
  networking.networkmanager.dns = "none";
  services.resolved.enable = false;
  
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # obviously this is ONLY for nvidia cards
  hardware.nvidia = {
    # Modesetting is needed most of the time
    modesetting.enable = true;

    # Enable power management (do not disable this unless you have a reason to).
    # Likely to cause problems on laptops and with screen tearing if disabled.
    powerManagement.enable = true;

    # Use the NVidia open source kernel module (which isn't “nouveau”).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # this support settings compiles SO MANY THINGS it crashes the machine - don't bother
  # nixpkgs.config.cudaSupport = true;

  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    layout = "us";
    desktopManager = {
      xterm.enable = false;
      cinnamon.enable = true;
    };
    displayManager.defaultSession = "cinnamon";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  
  systemd.services.cups-browsed = {
    wantedBy = pkgs.lib.mkForce [];
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # disable bluetooth
  hardware.bluetooth.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # file systems - example mounting another drive
  #fileSystems."/mnt/spinner" =
  #  { device = "/dev/disk/by-label/data1";
  #    fsType = "ext4";
  #  };

  # NFS mount to another system
  #fileSystems."/mnt/hostname" = {
  #  device = "ipaddress:/export/foldername";
  #  fsType = "nfs";
  #  options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=1800" ]; # lazy mount and auto disconnect after 30 minutes of no use
  #};

  # groups
  users.groups.brent.gid = 1000;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # enable fish
  programs.fish.enable = true;
  users.users.brent = {
    isNormalUser = true;
    group = "brent";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bind # dns utils
    docker
    docker-compose
    fuse3
    gimp
    git
    github-desktop
    gnugrep
    htop
    kopia
    libreoffice
    mariadb-client
    nodejs_18
    openssl
    python3
    screen
    sshfs
    system-config-printer
    terminator
    tldr
    unzip
    vim
    virt-manager
    virtiofsd
    wget
    yarn
    zip
  ];

  fonts.packages = with pkgs; [
    # fira-code
    # fira-code-symbols
    hack-font
    noto-fonts
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # timer jobs - this example runs a shell script at midnight daily
  #systemd.services = {
  #  kopia-backup = {
  #    path = [
  #      pkgs.bash
  #      pkgs.kopia
  #    ];
  #    script = builtins.readFile /home/brent/bin/kopiabackup.sh;
  #    serviceConfig = {
  #      User = "root";
  #    };
  #    # for date/time formats see https://www.freedesktop.org/software/systemd/man/systemd.time.html
  #    startAt = "daily"; # *-*-* 00:00:00
  #  };
  #};

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

