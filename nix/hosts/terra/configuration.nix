{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./amdgpu.nix
    ../../users/juno.nix
    ../../features/shell.nix
    ../../features/desktop.nix
    ../../features/games.nix
    # ../../features/i2pd-container.nix
    ../../programs/neovim.nix
    # /nix/programs/firefox.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  programs.firefox.enable = true;

  networking.hostName = "terra";
  networking.networkmanager.enable = true;
  networking.wireless.enable = true;

  # TODO: Bind port in modem
  networking.firewall.allowedTCPPorts = [
    2234 # Soulseek port
  ];

  # networking.hosts = {
  #   "74.208.51.189" = [ "jupyter" ];
  #   "192.168.100.81" = [ "venus" ];
  # };

  system.stateVersion = "26.05";
 }
