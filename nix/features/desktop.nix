{ pkgs, inputs, ... }: {
  imports = [
    inputs.noctalia-greeter.nixosModules.default
    inputs.noctalia.nixosModules.default
  ];

  environment.systemPackages = with pkgs; [
    # inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    xwayland-satellite
    ddcutil
    blueman
    gnome-text-editor
    kdePackages.koko
    gnome-feeds
    nautilus
    mpv
    font-manager
    swayimg
    gpu-screen-recorder
    alsa-utils
    alsa-tools
  ];

  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (subject.isInGroup("wheel"))
          return polkit.Result.YES;
      });
    '';
  };

  services.tuned.enable = true;
  services.upower.enable = true;

  programs.niri.enable = true;
  systemd.user.services.niri.enableDefaultPath = false;

  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
    systemd.enable = true;
  };

  programs.noctalia-greeter = {
    enable = true;
    package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;

    settings.cursor = {
      theme = "Adwaita";
      size = 24;
      package = pkgs.adwaita-icon-theme;
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.jetbrains-mono
    nerd-fonts.lekton
    nerd-fonts.mononoki
    nerd-fonts.terminess-ttf
  ];
}
