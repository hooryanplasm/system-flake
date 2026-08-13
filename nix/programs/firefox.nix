{ pkgs, inputs, ...}: {

  programs.firefox = {
    enable = true;
    package =  inputs.firefox.packages.${pkgs.stdenv.hostPlatform.system}.firefox-nightly-bin;
    languagePacks = [ "en-US" ];

    preferences = {
      "privacy.resistFingerprinting"  = true;
    };

    policies = {
      DisableTelemetry = true;
    };
  };
}
