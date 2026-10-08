{ ... }: {
  # networking.nat = {
  #   enable = true;
  #   # Use "ve-*" when using nftables instead of iptables
  #   internalInterfaces = ["ve-+"];
  #   externalInterface = "ens3";
  #   # Lazy IPv6 connectivity for the container
  #   # enableIPv6 = true;
  # };

  containers.pg-local= {
    autoStart = false;
    privateNetwork = false;
    # hostAddress = "192.168.100.10";
    # localAddress = "0.0.0.0";
    # hostAddress6 = "fc00::1";
    # localAddress6 = "fc00::2";
    config = { pkgs, ... }: {
      services.postgresql = {
        enable = true;
        ensureDatabases = [ "postgres" ];
        enableTCPIP = true;
        # port = 5432;
        authentication = pkgs.lib.mkOverride 10 ''
          #type database DBuser origin-address auth-method
          local all      all     trust
          # ... other auth rules ...

          # ipv4
          host  all      all     127.0.0.1/32   trust
          # ipv6
          host  all      all     ::1/128        trust
        '';
        initialScript = pkgs.writeText "backend-initScript" ''
          CREATE ROLE postgres WITH LOGIN PASSWORD 'pstgres' CREATEDB;
          CREATE DATABASE postgres;
          GRANT ALL PRIVILEGES ON DATABASE postgres TO postgres;
        '';
      };

    };
  };
}
