{ pkgs, ... }: {
  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    # jc 141
    bubblewrap
    fuse-overlayfs
    dwarfs

    lutris
    protonup-qt
    (retroarch.withCores
      (cores: with cores; [
        swanstation     # PS1 - modern
        beetle-psx-hw   # PS1 - accurate
        snes9x          # SNES
        mgba            # GBA
        genesis-plus-gx # Genesis
      ])
    )
  ];
}
