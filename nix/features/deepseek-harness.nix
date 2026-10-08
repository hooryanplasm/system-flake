{ inputs, pkgs, ... }: {
  imports = [ inputs.deepseek-harness.nixosModules.default ];

  programs.dsh = {
    profiles.web.bundles = [ pkgs.dsh.bundles.web-app ];

    patch = [
      {
        id = "webserver";
        config = {
          host = "0.0.0.0";
          port = 3080;
          compression = "gzip";
          compressionLevel = 1;
          compressionThresholdBytes = 1024;
        };
      }
    ];
  };

  services.dsh = {
    enable = true;
    trustedHosts = [ "venus" "venus.local" ];
  };

  networking.firewall.interfaces."wlp0s20f3".allowedTCPPorts = [ 3080 ];

  nix.settings = {
    substituters = [
      "https://cache.nixos.org/"
      "https://deepseek-harness-nix.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "deepseek-harness-nix.cachix.org-1:5NrkwLN9veNMhiINtU5ZeV4isXFhFsOwn6Ms7J1M+TA="
    ];
  };
}
