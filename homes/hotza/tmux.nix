{ pkgs, ... }:
{
  programs = {
    tmate.enable = true;

    tmux = {
      enable = true;

      aggressiveResize = true;
      baseIndex = 1;
      clock24 = true;
      sensibleOnTop = true;
      # This should either be screen-256color or tmux-256color where it exists
      terminal = "tmux-256color";
      prefix = "C-Space";

      plugins = [
        pkgs.tmuxPlugins.better-mouse-mode
        pkgs.tmuxPlugins.sensible
        pkgs.tmuxPlugins.vim-tmux-navigator
        pkgs.tmuxPlugins.yank
        {
          plugin = (pkgs.tmuxPlugins.tokyo-night-tmux.overrideAttrs ( _: {
            src = pkgs.fetchFromGitHub {
              owner = "PedroClerici";
              repo = "tokyo-night-tmux";
              rev = "f976b21d8d1f6ccf59785fca3f29985aadd62bad";
              sha256 = "sha256-M/LVHPt2ZyHvSBYPA4ys1kwQgGh58NLTmsccS+hNmVo=";
            };
            })
          );
          extraConfig = ''
            set -g @tokyo-night-tmux_show_datetime 0
            set -g @tokyo-night-tmux_window_id_style dsquare
            set -g @tokyo-night-tmux_show_git 0
          '';
        }
      ];

      extraConfig = ''
        # Vim style pane selection
        bind h select-pane -L
        bind j select-pane -D 
        bind k select-pane -U
        bind l select-pane -R

        # Start windows and panes at 1, not 0
        set -g base-index 1
        set -g pane-base-index 1
        set-window-option -g pane-base-index 1
        set-option -g renumber-windows on

        # Use Alt-arrow keys without prefix key to switch panes
        bind -n M-Left select-pane -L
        bind -n M-Right select-pane -R
        bind -n M-Up select-pane -U
        bind -n M-Down select-pane -D

        # Shift arrow to switch windows
        bind -n S-Left  previous-window
        bind -n S-Right next-window

        # Shift Alt vim keys to switch windows
        bind -n M-H previous-window
        bind -n M-L next-window

        # Where this shows 'alacritty' - the value should be whatever $TERM is outside tmux
        set-option -ga terminal-overrides ",alacritty:Tc"
      '';
    };
  };
}
