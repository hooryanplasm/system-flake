{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  time.timeZone = "America/Mazatlan";
  i18n.defaultLocale = "en_US.UTF-8";
  services.printing.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users."juno" = {
    isNormalUser = true;
    description = "juno";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      librewolf
      calibre
      qbittorrent-enhanced
      ungoogled-chromium
      amberol
      tauon
      chafa # Something depends of this, can't remember
      btop
      yazi
      zathura
      keepassxc
      nicotine-plus
      foliate
      krita
      gnumeric
      kdePackages.ark
      rar
      gnome-disk-utility

      opencode
      pi-coding-agent
      antigravity-ide
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    nssmdns
    fastfetch
    xdelta
    pciutils
    gzip
    p7zip
    file
    hyfetch
    freshfetch
    ipfetch
    typescript
    gcc
    bun
    nodejs
    pnpm
    python3
    postgresql
    openjdk
    cmake
    mpv
    net-tools
    # terminals
    ghostty
    alacritty
    kitty
    kitty-images
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
      AllowUsers = [ "juno" ];
    };
  };

  virtualisation.docker.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.accept-flake-config = false;
}
