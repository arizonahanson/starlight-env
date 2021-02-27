{ cfg, pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation {
  name = "zdot";
  src = ./.;
  installPhase = ''
    mkdir -p $out

    cat > $out/.zenv <<EOF
    # Only execute this file once per shell.
    if [ -n "\$__ZDOT_ZSHENV_SOURCED" ]; then return; fi
    __ZDOT_ZSHENV_SOURCED=1
    if test -r "\$HOME/.zenv"; then
      source "\$HOME/.zenv"
    fi
    EOF

    cat > $out/.zprofile <<EOF
    # Only execute this file once per shell.
    if [ -n "\$__ZDOT_ZPROFILE_SOURCED" ]; then return; fi
    __ZDOT_ZPROFILE_SOURCED=1
    if test -r "\$HOME/.zprofile"; then
      source "\$HOME/.zprofile"
    fi
    # Setup login shell init stuff.
    #eval \$(dircolors -b /etc/dircolors)
    if [ -n "\$XDG_CACHE_HOME" ]; then
      mkdir -p "\$XDG_CACHE_HOME"
    fi
    if [ -n "\$XDG_CONFIG_HOME" ]; then
      mkdir -p "\$XDG_CONFIG_HOME"
    fi
    EOF

    cat > $out/.zshrc <<EOF
    # Only execute this file once per shell.
    if [ -n "\$__ZDOT_ZSHRC_SOURCED" ]; then return; fi
    __ZDOT_ZSHRC_SOURCED=1
    HISTFILE="\$HOME/.zsh_history"
    if test -r "\$HOME/.zshrc"; then
      source "\$HOME/.zshrc"
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
