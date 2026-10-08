{ pkgs, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../users/juno.nix
    ../../features/shell.nix
    # ../../features/desktop.nix
    ../../features/games.nix
    ../../programs/neovim.nix
    ../../programs/firefox.nix
    ../../containers/postgres.nix
    inputs.deepseek-harness.nixosModules.default
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "venus";
  networking.networkmanager.enable = true;

  # Plasma 6
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;
  services.blueman.enable = true;

  services.dsh = {
    enable = true;
    listenAddress = "127.0.0.1";
    port = 3080;
    #trustedHosts = [ "dsh.example.com" ];
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

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

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Core Graphics / GLX (Fixes the GLX error)
    libglvnd
    # X11 / Windowing dependencies
    libX11
    libXext
    libXcursor
    libXrandr
    libXi
    libXxf86vm
    libXfixes
    libXrender
    glfw
    # Audio (Fixes the Pipewire/Qt warning)
    openal
    pipewire
    libpulseaudio
  ];

  environment.systemPackages = with pkgs; [
    proton-vpn
    libcamera
    libcamera-qcam
    xclip
    libplacebo
    # linuxKernel.packages.linux_7_1.cpupower
    supabase-cli
    # ....
    glfw
    kdePackages.kdialog
    zenity
    xprop

    # blog2epub
    pipx
    pkg-config
    python313Packages.pycairo
    cairo
  ];

  system.stateVersion = "26.05";
}
