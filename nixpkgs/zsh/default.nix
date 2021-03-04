{ cfg, pkgs ? import <nixpkgs> { } }:
let
  dircolors = pkgs.writeTextFile {
    name = "dircolors";
    destination = "/etc/dircolors";
    text = ''
      # Configuration file for dircolors, a utility to help you set the
      # LS_COLORS environment variable used by GNU ls with the --color option.
      # Copyright (C) 1996-2019 Free Software Foundation, Inc.
      # Copying and distribution of this file, with or without modification,
      # are permitted provided the copyright notice and this notice are preserved.
      # The keywords COLOR, OPTIONS, and EIGHTBIT (honored by the
      # slackware version of dircolors) are recognized but ignored.
      # Below are TERM entries, which can be a glob patterns, to match
      # against the TERM environment variable to determine if it is colorizable.
      TERM Eterm
      TERM ansi
      TERM *color*
      TERM con[0-9]*x[0-9]*
      TERM cons25
      TERM console
      TERM cygwin
      TERM dtterm
      TERM gnome
      TERM hurd
      TERM jfbterm
      TERM konsole
      TERM kterm
      TERM linux
      TERM linux-c
      TERM mlterm
      TERM putty
      TERM rxvt*
      TERM screen*
      TERM st
      TERM terminator
      TERM tmux*
      TERM vt100
      TERM xterm*
      # Below are the color init strings for the basic file types.
      # One can use codes for 256 or more colors supported by modern terminals.
      # The default color codes use the capabilities of an 8 color terminal
      # with some additional attributes as per the following codes:
      # Attribute codes:
      # 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
      # Text color codes:
      # 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
      # Background color codes:
      # 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white
      #NORMAL 00 # no color code at all
      #FILE 00 # regular file: use no color at all
      RESET 0 # reset to "normal" color
      DIR 38;5;${cfg.theme.path} # directory
      LINK target # symbolic link. (If you set this to 'target' instead of a
       # numerical value, the color is as for the file pointed to.)
      MULTIHARDLINK 00 # regular file with more than one link
      FIFO 38;5;${cfg.theme.socket} # pipe
      SOCK 38;5;${cfg.theme.socket};4 # socket
      DOOR 38;5;${cfg.theme.socket};7 # door
      BLK 38;5;${cfg.theme.string} # block device driver
      CHR 38;5;${cfg.theme.character} # character device driver
      ORPHAN 38;5;${cfg.theme.error} # symlink to nonexistent file, or non-stat'able file ...
      MISSING 38;5;${cfg.theme.bg-alt} # ... and the files they point to
      SETUID 38;5;${cfg.theme.warning} # file that is setuid (u+s)
      SETGID 38;5;${cfg.theme.warning};4 # file that is setgid (g+s)
      CAPABILITY 38;5;${cfg.theme.warning};7 # file with capability
      STICKY_OTHER_WRITABLE 38;5;${cfg.theme.path};4;7 # dir that is sticky and other-writable (+t,o+w)
      OTHER_WRITABLE 38;5;${cfg.theme.path};7 # dir that is other-writable (o+w) and not sticky
      STICKY 38;5;${cfg.theme.path};4 # dir with the sticky bit set (+t) and not other-writable
      # This is for files with execute permission:
      EXEC 38;5;${cfg.theme.executable}
      # List any file extensions like '.gz' or '.tar' that you would like ls
      # to colorize below. Put the extension, a space, and the color init string.
      # (and any comments you want to add after a '#')
      # Or if you want to colorize scripts even if they do not have the
      # executable bit actually set.
      .sh 38;5;${cfg.theme.executable}
      .csh 38;5;${cfg.theme.executable}
      .py 38;5;${cfg.theme.function}
      .js 38;5;${cfg.theme.function}
      .go 38;5;${cfg.theme.function}
       # archives or compressed
      .tar 01;31
      .tgz 01;31
      .arc 01;31
      .arj 01;31
      .taz 01;31
      .lha 01;31
      .lz4 01;31
      .lzh 01;31
      .lzma 01;31
      .tlz 01;31
      .txz 01;31
      .tzo 01;31
      .t7z 01;31
      .zip 01;31
      .z 01;31
      .dz 01;31
      .gz 01;31
      .lrz 01;31
      .lz 01;31
      .lzo 01;31
      .xz 01;31
      .zst 01;31
      .tzst 01;31
      .bz2 01;31
      .bz 01;31
      .tbz 01;31
      .tbz2 01;31
      .tz 01;31
      .deb 01;31
      .rpm 01;31
      .jar 01;31
      .war 01;31
      .ear 01;31
      .sar 01;31
      .rar 01;31
      .alz 01;31
      .ace 01;31
      .zoo 01;31
      .cpio 01;31
      .7z 01;31
      .rz 01;31
      .cab 01;31
      .wim 01;31
      .swm 01;31
      .dwm 01;31
      .esd 01;31
      # image formats
      .jpg 01;35
      .jpeg 01;35
      .mjpg 01;35
      .mjpeg 01;35
      .gif 01;35
      .bmp 01;35
      .pbm 01;35
      .pgm 01;35
      .ppm 01;35
      .tga 01;35
      .xbm 01;35
      .xpm 01;35
      .tif 01;35
      .tiff 01;35
      .png 01;35
      .svg 01;35
      .svgz 01;35
      .mng 01;35
      .pcx 01;35
      .mov 01;35
      .mpg 01;35
      .mpeg 01;35
      .m2v 01;35
      .mkv 01;35
      .webm 01;35
      .ogm 01;35
      .mp4 01;35
      .m4v 01;35
      .mp4v 01;35
      .vob 01;35
      .qt 01;35
      .nuv 01;35
      .wmv 01;35
      .asf 01;35
      .rm 01;35
      .rmvb 01;35
      .flc 01;35
      .avi 01;35
      .fli 01;35
      .flv 01;35
      .gl 01;35
      .dl 01;35
      .xcf 01;35
      .xwd 01;35
      .yuv 01;35
      .cgm 01;35
      .emf 01;35
      # https://wiki.xiph.org/MIME_Types_and_File_Extensions
      .ogv 01;35
      .ogx 01;35
      # audio formats
      .aac 00;36
      .au 00;36
      .flac 00;36
      .m4a 00;36
      .mid 00;36
      .midi 00;36
      .mka 00;36
      .mp3 00;36
      .mpc 00;36
      .ogg 00;36
      .ra 00;36
      .wav 00;36
      # https://wiki.xiph.org/MIME_Types_and_File_Extensions
      .oga 00;36
      .opus 00;36
      .spx 00;36
      .xspf 00;36
      # additional highlighting
      .pid 38;5;${cfg.theme.bg-alt}
      *~ 38;5;${cfg.theme.bg-alt}
      .gitignore 38;5;${cfg.theme.fg-alt}
    '';
  };
  toFG = str: "%{$FG[${pkgs.lib.fixedWidthString 3 "0" str}]%}";
  zshtheme = pkgs.writeTextFile {
    name = "zshtheme";
    destination = "/themes/starlight.zsh-theme";
    text = ''
      git_prompt_status() {
        git_root=$PWD
        unset STATUS
        while [[ $git_root != / && ! -e $git_root/.git ]]; do
          git_root=$git_root:h
        done
        if [ ! $git_root = / ]; then
          GIT_STASHED=$(git stash list 2>/dev/null | wc -l)
          if [ "$GIT_UNTRACKED" -ne "0" ]; then
              STATUS="$STATUS${toFG cfg.theme.diff-remove}$ZSH_THEME_GIT_PROMPT_UNTRACKED%{$reset_color%}"
          fi
          if [ "$GIT_STAGED" -ne "0" ]; then
              STATUS="$STATUS${toFG cfg.theme.staged}$ZSH_THEME_GIT_PROMPT_STAGED%{$reset_color%}"
          fi
          if [ "$GIT_CONFLICTS" -ne "0" ]; then
              STATUS="$STATUS${toFG cfg.theme.error}$ZSH_THEME_GIT_PROMPT_CONFLICTS%{$reset_color%}"
          fi
          if [ "$GIT_CHANGED" -ne "0" ]; then
              STATUS="$STATUS${toFG cfg.theme.diff-change}$ZSH_THEME_GIT_PROMPT_CHANGED%{$reset_color%}"
          fi
          if [ "$GIT_STASHED" -ne "0" ]; then
              STATUS="$STATUS${toFG cfg.theme.localBranch}$GIT_STASHED$ZSH_THEME_GIT_PROMPT_STASHED%{$reset_color%}"
          fi
          if [ "$GIT_BEHIND" -ne "0" ]; then
              STATUS="$STATUS${toFG cfg.theme.warning}$GIT_BEHIND$ZSH_THEME_GIT_PROMPT_BEHIND%{$reset_color%}"
          fi
          if [ "$GIT_AHEAD" -ne "0" ]; then
              STATUS="$STATUS${toFG cfg.theme.diff-add}$GIT_AHEAD$ZSH_THEME_GIT_PROMPT_AHEAD%{$reset_color%}"
          fi
          if [ "$GIT_CLEAN" -eq "1" ]; then
              STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CLEAN"
          fi
          STATUS="%{$reset_color%}$ZSH_THEME_GIT_PROMPT_PREFIX"''${STATUS:+"$STATUS$ZSH_THEME_GIT_PROMPT_SEPARATOR"}
          STATUS="$STATUS${toFG cfg.theme.currentBranch}$ZSH_THEME_GIT_PROMPT_BRANCH$GIT_BRANCH%{$reset_color%}$ZSH_THEME_GIT_PROMPT_SEPARATOR"
          parent=''${git_root%\/*}
          WORKDIR="${toFG cfg.theme.path}''${PWD#$parent/}%{$reset_color%}"
        else
          if [ "$PWD" = "$HOME" ]; then
            WORKDIR="${toFG cfg.theme.path}$ZSH_THEME_GIT_PROMPT_HOME%{$reset_color%}"
          else
            WORKDIR="${toFG cfg.theme.path}%3~%{$reset_color%}"
          fi
        fi
        unset git_root
        PROMPT="%(?.${toFG cfg.theme.fg-alt}.${toFG cfg.theme.error})$ZSH_THEME_GIT_PROMPT_PROMPT%{$reset_color%} "
        PS2="%{$reset_color%}${toFG cfg.theme.warning}$ZSH_THEME_GIT_PROMPT_PROMPT2%{$reset_color%}"
        RPROMPT="$STATUS$WORKDIR$ZSH_THEME_GIT_PROMPT_SUFFIX"
      }
      autoload -U add-zsh-hook
      add-zsh-hook precmd git_prompt_status
      ZSH_THEME_GIT_PROMPT_PREFIX=""
      ZSH_THEME_GIT_PROMPT_SUFFIX=""
      ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
      ZSH_THEME_GIT_PROMPT_PROMPT=""
      ZSH_THEME_GIT_PROMPT_PROMPT2="   "
      ZSH_THEME_GIT_PROMPT_BRANCH=""
      ZSH_THEME_GIT_PROMPT_STAGED=" "
      ZSH_THEME_GIT_PROMPT_CONFLICTS=" "
      ZSH_THEME_GIT_PROMPT_CHANGED=" "
      ZSH_THEME_GIT_PROMPT_UNTRACKED=" "
      ZSH_THEME_GIT_PROMPT_STASHED=""
      ZSH_THEME_GIT_PROMPT_BEHIND=""
      ZSH_THEME_GIT_PROMPT_AHEAD=""
      ZSH_THEME_GIT_PROMPT_CLEAN=""
      if [ -n "$SSH_TTY" ]; then
        ZSH_THEME_GIT_PROMPT_HOME=" "
      else
        ZSH_THEME_GIT_PROMPT_HOME=" "
      fi
    '';
  };
in
pkgs.stdenv.mkDerivation {
  name = "myzsh";
  src = ./.;
  buildInputs = with pkgs; [
    makeWrapper
    nix-zsh-completions
    oh-my-zsh
    zsh
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
    (dircolors)
    (zshtheme)
  ];
  installPhase = ''
    makeWrapper "${pkgs.zsh}/bin/zsh" "$out/bin/zsh" --set ZDOTDIR $out

    cat > $out/.zshenv <<EOF
    # Only execute this file once per shell.
    if [ -n "\$__ZDOT_ZSHENV_SOURCED" ]; then return; fi
    __ZDOT_ZSHENV_SOURCED=1
    umask 077
    if test -r "\$HOME/.zshenv"; then
      source "\$HOME/.zshenv"
    fi
    EOF

    cat > $out/.zshrc <<EOF
    # Only execute this file once per interactive shell.
    if [ -n "\$__ZDOT_ZSHRC_SOURCED" ]; then return; fi
    __ZDOT_ZSHRC_SOURCED=1
    HISTFILE="\$HOME/.zsh_history"
    export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh
    ZSH_THEME="starlight"
    ZSH_CUSTOM="${zshtheme}"
    plugins=(git colored-man-pages git-prompt)
    eval \$(dircolors -b ${dircolors}/etc/dircolors)
    fpath=(${pkgs.zsh-completions}/share/zsh/site-functions ${pkgs.nix-zsh-completions}/share/zsh/site-functions \$fpath)
    # fzf with tmux
    source ${pkgs.fzf}/share/fzf/key-bindings.zsh
    source ${pkgs.fzf}/share/fzf/completion.zsh
    zstyle ':completion:*:default' list-colors \''${(s.:.)LS_COLORS} ma='48;5;${cfg.theme.bg-alt};38;5;${cfg.theme.select}'
    source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    export ZSH_HIGHLIGHT_STYLES[cursor]='fg=${cfg.theme.select}'
    export ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='fg=${cfg.theme.match}'
    export ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=${cfg.theme.error}'
    export ZSH_HIGHLIGHT_STYLES[path]='fg=${cfg.theme.path}'
    export ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=${cfg.theme.match}'
    export ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=${cfg.theme.pattern}'
    export ZSH_HIGHLIGHT_STYLES[globbing]='fg=${cfg.theme.pattern}'
    export ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=${cfg.theme.character}'
    export ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=${cfg.theme.character}'
    export ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=${cfg.theme.string}'
    export ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=${cfg.theme.function}'
    export ZSH_HIGHLIGHT_STYLES[alias]='fg=${cfg.theme.function}'
    export ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=${cfg.theme.substitution}'
    export ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=${cfg.theme.substitution}'
    export ZSH_HIGHLIGHT_STYLES[function]='fg=${cfg.theme.function}'
    export ZSH_HIGHLIGHT_STYLES[precommand]='fg=${cfg.theme.warning}'
    export ZSH_HIGHLIGHT_STYLES[command]='fg=${cfg.theme.executable}'
    export ZSH_HIGHLIGHT_STYLES[builtin]='fg=${cfg.theme.statement}'
    export ZSH_HIGHLIGHT_STYLES[redirection]='fg=${cfg.theme.keyword}'
    export ZSH_HIGHLIGHT_STYLES[arg0]='fg=${cfg.theme.keyword}'
    export ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=${cfg.theme.keyword}'
    export ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=${cfg.theme.keyword}'
    export ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=${cfg.theme.constant}'
    export ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=${cfg.theme.constant}'
    export ZSH_HIGHLIGHT_STYLES[assign]='fg=${cfg.theme.fg-alt}'
    export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=${cfg.theme.bg-alt}"
    export ZSH_AUTOSUGGEST_STRATEGY=("match_prev_cmd")
    ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=vi-forward-char
    autoload -Uz run-help
    unalias run-help
    alias help=run-help
    # spellcheck commands
    setopt correct
    # turn off completion beeps
    unsetopt LIST_BEEP
    if test -r "\$HOME/.zshrc"; then
      source "\$HOME/.zshrc"
    fi
    source \$ZSH/oh-my-zsh.sh
    # vi-like editing
    bindkey -v
    # backspace
    bindkey -a '^?' vi-backward-delete-char
    # home
    bindkey -a '\\e[1~' vi-first-non-blank
    bindkey '\\e[1~' vi-first-non-blank
    # insert
    bindkey -a '\\e[2~' vi-insert
    bindkey '\\e[2~' vi-insert # noop?
    # delete
    bindkey '\\e[3~' vi-delete-char
    bindkey -a '\\e[3~' vi-delete-char
    # end
    bindkey -a '\\e[4~'  vi-end-of-line
    bindkey '\\e[4~'  vi-end-of-line
    bindkey  "\''${terminfo[khome]}" vi-beginning-of-line
    bindkey -a "\''${terminfo[khome]}" vi-beginning-of-line
    bindkey  "\''${terminfo[kend]}" vi-end-of-line
    bindkey -a "\''${terminfo[kend]}" vi-end-of-line
    # complete word
    bindkey '^w' vi-forward-word
    bindkey '^ ' autosuggest-accept
    bindkey '^G' fzf-cd-widget
    source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    # keep zcompdump in tmp
    autoload -U compinit && compinit -d "$TMP/.$USER/zcompdump"
    # save prompt status
    zle-line-init() {
      typeset -g __prompt_status="\$?"
    }
    zle -N zle-line-init
    zle-keymap-select () {
      if [ ! "\$TERM" = "linux" ]; then
        if [ \$KEYMAP = vicmd ]; then
          echo -ne "\\e[1 q"
        else
          if [[ \$ZLE_STATE == *insert* ]]; then
            echo -ne "\\e[5 q"
          else
            echo -ne "\\e[3 q"
          fi
        fi
      fi
      () { return \$__prompt_status }
      zle reset-prompt
    }
    zle -N zle-keymap-select
    precmd() {
      if [ ! "\$TERM" = "linux" ]; then
        echo -ne "\\e[5 q"
      fi
    }
    # Load the aliases.
    . "\$ZDOTDIR/.zsh_aliases"
    if [ -f ~/.zsh_aliases ]; then
        . ~/.zsh_aliases
    fi
    EOF
    cat > $out/.zsh_aliases <<EOF
    unalias ls
    alias ls="ls --color";
    alias l="ls -hF";
    alias la="ls -AhF";
    alias ll="ls -lAhF";
    alias lt="tree -aFC -I .git -L 2";
    alias cp="cp --reflink=auto";
    alias xz="xz --threads=0";
    alias ag="${pkgs.ag}/bin/ag --color-line-number '38;5;${cfg.theme.bg-alt}' --color-path '38;5;${cfg.theme.path}' --color-match '38;5;${cfg.theme.match}'";
    EOF

    cat > $out/.zlogin <<EOF
    if test -r ~/.zlogin; then
      . ~/.zlogin
    fi
    EOF

    cat > $out/.zlogout <<EOF
    if test -r ~/.zlogout; then
      . ~/.zlogout
    fi
    EOF
  '';
}
