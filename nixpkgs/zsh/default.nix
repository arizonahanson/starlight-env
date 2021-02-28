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
      DIR 38;5;${toString cfg.theme.path} # directory
      LINK target # symbolic link. (If you set this to 'target' instead of a
       # numerical value, the color is as for the file pointed to.)
      MULTIHARDLINK 00 # regular file with more than one link
      FIFO 38;5;${toString cfg.theme.socket} # pipe
      SOCK 38;5;${toString cfg.theme.socket};4 # socket
      DOOR 38;5;${toString cfg.theme.socket};7 # door
      BLK 38;5;${toString cfg.theme.string} # block device driver
      CHR 38;5;${toString cfg.theme.character} # character device driver
      ORPHAN 38;5;${toString cfg.theme.error} # symlink to nonexistent file, or non-stat'able file ...
      MISSING 38;5;${toString cfg.theme.bg-alt} # ... and the files they point to
      SETUID 38;5;${toString cfg.theme.warning} # file that is setuid (u+s)
      SETGID 38;5;${toString cfg.theme.warning};4 # file that is setgid (g+s)
      CAPABILITY 38;5;${toString cfg.theme.warning};7 # file with capability
      STICKY_OTHER_WRITABLE 38;5;${toString cfg.theme.path};4;7 # dir that is sticky and other-writable (+t,o+w)
      OTHER_WRITABLE 38;5;${toString cfg.theme.path};7 # dir that is other-writable (o+w) and not sticky
      STICKY 38;5;${toString cfg.theme.path};4 # dir with the sticky bit set (+t) and not other-writable
      # This is for files with execute permission:
      EXEC 38;5;${toString cfg.theme.executable}
      # List any file extensions like '.gz' or '.tar' that you would like ls
      # to colorize below. Put the extension, a space, and the color init string.
      # (and any comments you want to add after a '#')
      # Or if you want to colorize scripts even if they do not have the
      # executable bit actually set.
      .sh 38;5;${toString cfg.theme.executable}
      .csh 38;5;${toString cfg.theme.executable}
      .py 38;5;${toString cfg.theme.function}
      .js 38;5;${toString cfg.theme.function}
      .go 38;5;${toString cfg.theme.function}
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
      .pid 38;5;${toString cfg.theme.bg-alt}
      *~ 38;5;${toString cfg.theme.bg-alt}
      .gitignore 38;5;${toString cfg.theme.fg-alt}
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
  ];
  installPhase = ''
    makeWrapper "${pkgs.zsh}/bin/zsh" "$out/bin/zsh" --set ZDOTDIR $out

    cat > $out/.zenv <<EOF
    # Only execute this file once per shell.
    if [ -n "\$__ZDOT_ZSHENV_SOURCED" ]; then return; fi
    __ZDOT_ZSHENV_SOURCED=1
    if test -r "\$HOME/.zenv"; then
      source "\$HOME/.zenv"
    fi
    EOF

    cat > $out/.zprofile <<EOF
    # Only execute this file once per login shell.
    if [ -n "\$__ZDOT_ZPROFILE_SOURCED" ]; then return; fi
    __ZDOT_ZPROFILE_SOURCED=1
    if test -r "\$HOME/.zprofile"; then
      source "\$HOME/.zprofile"
    fi
    # Setup login shell init stuff.
    if [ -n "\$XDG_CACHE_HOME" ]; then
      mkdir -p "\$XDG_CACHE_HOME"
    fi
    if [ -n "\$XDG_CONFIG_HOME" ]; then
      mkdir -p "\$XDG_CONFIG_HOME"
    fi
    EOF

    cat > $out/.zshrc <<EOF
    # Only execute this file once per interactive shell.
    if [ -n "\$__ZDOT_ZSHRC_SOURCED" ]; then return; fi
    __ZDOT_ZSHRC_SOURCED=1
    HISTFILE="\$HOME/.zsh_history"
    export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh
    ZSH_THEME="random"
    plugins=(git colored-man-pages)
    eval \$(dircolors -b ${dircolors}/etc/dircolors)
    fpath=(${pkgs.zsh-completions}/share/zsh/site-functions ${pkgs.nix-zsh-completions}/share/zsh/site-functions \$fpath)
    source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # better 'help'
    autoload -Uz run-help
    unalias run-help
    alias help=run-help
    if test -r "\$HOME/.zshrc"; then
      source "\$HOME/.zshrc"
    fi
    source \$ZSH/oh-my-zsh.sh
    # Load the aliases.
    if [ -f ~/.zsh_aliases ]; then
        . ~/.zsh_aliases
    fi
    EOF

    cat > $out/.zlogin <<EOF
    if test -r "\$HOME/.zlogin"; then
      source "\$HOME/.zlogin"
    fi
    EOF

    cat > $out/.zlogout <<EOF
    if test -r "\$HOME/.zlogout"; then
      source "\$HOME/.zlogout"
    fi
    EOF
  '';
}
