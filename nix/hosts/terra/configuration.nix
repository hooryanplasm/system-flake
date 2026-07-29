{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./amdgpu.nix
    ./networking.nix
    ./system.nix
    ../../features/shell.nix
    ../../features/desktop.nix
    ../../features/games.nix
    ../../features/i2pd-container.nix
    ../../programs/neovim.nix
    # /nix/programs/firefox.nix
  ];

  nixpkgs.config.allowUnfree = true;

  users.users."juno" = {
    isNormalUser = true;
    description = "juno";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      librewolf
      calibre
      qbittorrent-enhanced
      alacritty
      antigravity
      ungoogled-chromium
      amberol
      tauon
      chafa
      btop
      yazi
      #retroshare
      zathura
      keepassxc
      nicotine-plus
      foliate
      krita
      gnumeric
      # emacs packages
      emacs-gtk
      dockerfmt
      clang-tools
      glslang
      sqlite
      pandoc
      graphviz
      shfmt
      shellcheck
      html-tidy
      stylelint
      js-beautify
      ispell
      ghostty
      tor-browser
      kdePackages.ark
      rar
    ];
  };

  environment.systemPackages = with pkgs; [
    # basic system packages
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
    #langs
    typescript
    gcc
    bun
    nodejs
    python3
    postgresql
    openjdk
    cmake
  ];

  programs.firefox.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh = {
    enable = true;
    permitRootLogin = "prohibit-password";
    passwordAuthentication = false;
  };

  virtualisation.docker.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.accept-flake-config = false;

  system.stateVersion = "26.05";
 }
