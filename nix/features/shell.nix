{ pkgs, ... }: {
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting

      fish_vi_key_bindings
      set fish_vi_force_cursor 1

      alias vim="nvim"
      alias add="git add ."
      alias commit="git commit -m"
      alias reload-ghostty="systemctl reload --user app-com.mitchellh.ghostty.service"
      alias kill-emacs='emacsclient -e "(kill-emacs)"'

      fish_add_path -g "$HOME/.config/emacs/bin/"

      function fish_user_key_bindings
        # Complete with menu (shows list)
        # bind -M insert '\c@' complete

        # Complete without menu (in-line)
        # bind -M insert \e complete

        # Accept autosuggestion
        bind -M insert \cy accept-autosuggestion
        bind -M normal \cy accept-autosuggestion

        # Cycle through completion suggestions
        bind -M insert \cp up-or-search
        bind -M insert \cn down-or-search

        # Navigate in completion menu
        bind -M insert \cp up-or-search
        bind -M insert \cn down-or-search

        # Press tab to open menu, then j/k to navigate
        bind -M insert \ct tab-command

        # complete -c docker -n "__fish_seen_subcommand_from stop" -a "(docker ps -a --format '{{.Names}}')" -d "Container"
      end
    '';
  };

  environment.systemPackages = with pkgs; [
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.colored-man-pages
    fishPlugins.grc
    # fishPlugins.forgit
    fishPlugins.tide
    fishPlugins.pisces
    fishPlugins.sponge
    #fishPlugins.async-prompt
    fzf
    grc
  ];
}
