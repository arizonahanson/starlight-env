{ cfg, pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation {
  name = "mytmux";
  src = ./.;
  buildInputs = [ pkgs.tmux pkgs.makeWrapper ];
  installPhase = ''
    mkdir -p $out/etc
    cat > $out/etc/tmux.conf <<EOF
    set -g history-limit 65535
    set -g display-time 4000
    set -g focus-events on
    setw -g aggressive-resize on
    set -g default-terminal "screen-256color"
    set -g set-titles on
    set -g set-titles-string "#W"
    set -g monitor-activity on
    set -s escape-time 0
    set -g status "on"
    set -g status-left-length "100"
    set -g status-right-length "100"
    set -g status-right ""
    set -g status-left ""
    set -g renumber-windows on
    setw -g window-status-separator ""
    setw -g window-status-current-format " #W "
    setw -g window-status-format " #W "
    set -g base-index 1
    setw -g pane-base-index 1
    #set -g word-separators " /@,=\"-"

    # default statusbar colors
    set-option -g status-style bg=colour${cfg.theme.bg},fg=colour${cfg.theme.fg}
    # default window title colors
    set-window-option -g window-status-style fg=colour${cfg.theme.bg-alt},bg=colour${cfg.theme.bg}
    # active window title colors
    set-window-option -g window-status-current-style fg=colour${cfg.theme.fg},bg=colour${cfg.theme.bg}
    # inactive window activity colors
    set-window-option -g window-status-activity-style fg=colour${cfg.theme.fg-alt},bg=colour${cfg.theme.bg}
    set-window-option -g window-status-bell-style fg=colour${cfg.theme.info},bg=colour${cfg.theme.bg}

    # pane border
    set-option -g pane-border-style fg=colour${cfg.theme.bg-alt}
    set-option -g pane-active-border-style fg=colour${cfg.theme.accent}

    # message text
    set-option -g message-style bg=colour${cfg.theme.bg},fg=colour${cfg.theme.fg}

    # pane number display
    set-option -g display-panes-active-colour colour${cfg.theme.fg}
    set-option -g display-panes-colour colour${cfg.theme.fg-alt}

    # clock
    set-window-option -g clock-mode-colour colour${cfg.theme.accent}

    # better vi-like bindings
    set -g mode-keys vi
    set -g status-keys "vi"
    bind-key -T copy-mode-vi Home "send-keys -X start-of-line"
    bind-key -T copy-mode-vi End "send-keys -X end-of-line"
    unbind-key -T copy-mode-vi v
    bind-key -T copy-mode-vi v "send-keys -X begin-selection"
    unbind-key -T copy-mode-vi y
    bind-key -T copy-mode-vi y "send-keys -X copy-selection-and-cancel"
    bind '"' split-window -c "#{pane_current_path}"
    bind % split-window -h -c "#{pane_current_path}"
    bind c new-window -c "#{pane_current_path}"
    EOF
    makeWrapper "${pkgs.tmux}/bin/tmux" "$out/bin/tmux" --add-flags "-f '$out/etc/tmux.conf'" \
      --set TZ America/New_York --set SHELL ${cfg.pkgs.myzsh}/bin/zsh
  '';
}
