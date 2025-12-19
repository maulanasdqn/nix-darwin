{ username, ... }:
{
  home-manager.users.${username}.programs.tmux.extraConfig = ''
    # Rose Pine theme
    set -g @rose_pine_variant 'main'

    # Status bar
    set -g status-position bottom
    set -g status-justify left
    set -g status-style 'bg=#191724 fg=#e0def4'

    # Pane borders
    set -g pane-border-style 'fg=#26233a'
    set -g pane-active-border-style 'fg=#c4a7e7'

    # Status bar content
    set -g status-left-length 40
    set -g status-right-length 100
    set -g status-left '#[fg=#191724,bg=#c4a7e7,bold] #S #[fg=#c4a7e7,bg=#191724]'
    set -g status-right '#[fg=#26233a,bg=#191724]#[fg=#e0def4,bg=#26233a] %H:%M #[fg=#c4a7e7,bg=#26233a]#[fg=#191724,bg=#c4a7e7,bold] %d-%m-%Y '

    # Window status
    set -g window-status-current-format '#[fg=#191724,bg=#c4a7e7]#[fg=#191724,bg=#c4a7e7,bold] #I #W #[fg=#c4a7e7,bg=#191724]'
    set -g window-status-format '#[fg=#6e6a86,bg=#191724] #I #W '

    # Message style
    set -g message-style 'fg=#e0def4 bg=#26233a'
    set -g message-command-style 'fg=#e0def4 bg=#26233a'

    # Copy mode style
    set -g mode-style 'fg=#e0def4 bg=#26233a'
  '';
}
