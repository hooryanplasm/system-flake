{ inputs, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  environment.systemPackages = with pkgs; [
    tree-sitter
    wl-clipboard-rs
    skim
    bat
    ripgrep
    fd
    delta
    jujutsu

    lua-language-server
    astro-language-server
    nixd
    pyright
    # Formatrers
    nixfmt-rs
    black
    isort
    prettier
    stylua
    codespell
    sqls
    # emacs packages
    emacs-gtk
    dockerfmt
    clang-tools
    glslang
    sqlite
    pandoc
    graphviz
    shfmt
    shellcheck
    html-tidy
    stylelint
    js-beautify
    ispell
  ];
}
