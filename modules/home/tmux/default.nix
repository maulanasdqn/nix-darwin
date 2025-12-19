{
  config,
  pkgs,
  lib,
  username,
  ...
}:
{
  imports = [
    ./keybindings.nix
    ./theme.nix
  ];

  home-manager.users.${username}.programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 10000;
    escapeTime = 0;
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";

    extraConfig = ''
      # Force zsh as default shell
      set -g default-command "${pkgs.zsh}/bin/zsh"
      set -g default-shell "${pkgs.zsh}/bin/zsh"

      # True color support
      set -ag terminal-overrides ",xterm-256color:RGB"

      # Renumber windows when one is closed
      set -g renumber-windows on

      # Don't rename windows automatically
      set -g allow-rename off

      # Enable mouse scrolling and selection
      set -g mouse on

      # Use vi keys in copy mode
      setw -g mode-keys vi
    '';

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '10'
        '';
      }
    ];
  };
}
