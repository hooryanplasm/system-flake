{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./amdgpu.nix
    ../../users/juno.nix
    ../../features/fish-shell.nix
    ../../features/desktop.nix
    ../../features/games.nix
    ../../programs/neovim.nix
    ../../programs/firefox.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # programs.firefox.enable = true;

  networking.hostName = "terra";
  networking.networkmanager.enable = true;
  networking.wireless.enable = true;

  # TODO: Forward port in modem
  networking.firewall.allowedTCPPorts = [
    2234 # Soulseek port
  ];
 }
