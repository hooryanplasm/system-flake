{ ... }: {
  networking.nat = {
    enable = true;
    # Use "ve-*" when using nftables instead of iptables
    internalInterfaces = ["ve-+"];
    externalInterface = "ens3";
    # Lazy IPv6 connectivity for the container
    # enableIPv6 = true;
  };

  containers.nextcloud = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "0.0.0.0";
    # hostAddress6 = "fc00::1";
    # localAddress6 = "fc00::2";
    config = { pkgs, lib, ... }: {


    };
  };
}
