{ ... }: {
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

  programs.mtr.enable = true;
}
