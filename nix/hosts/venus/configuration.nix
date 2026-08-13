{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../users/juno.nix
    ../../features/shell.nix
    # ../../features/desktop.nix
    ../../features/games.nix
    ../../programs/neovim.nix
    ../../programs/firefox.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "venus";
  networking.networkmanager.enable = true;

  # Plasma 6
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  services.blueman.enable = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver     # VA-API (iHD) userspace
      vpl-gpu-rt             # oneVPL (QSV) runtime
      intel-compute-runtime  # OpenCL (NEO) + Level Zero for Arc/Xe
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";     # Prefer the modern iHD backend
  };

  environment.systemPackages = with pkgs; [
    libcamera
    libcamera-qcam
    xclip
    libplacebo
    linuxKernel.packages.linux_7_1.cpupower
  ];

  system.stateVersion = "26.05";
}
