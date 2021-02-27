{ cfg, pkgs ? import <nixpkgs> { } }:

pkgs.stdenv.mkDerivation {
  name = "zdot";
  src = ./.;
  installPhase = ''
    mkdir -p $out

    cat > $out/.zenv <<EOF
    if test -r "\$HOME/.zenv"; then
      source "\$HOME/.zenv"
    fi
    EOF

    cat > $out/.zprofile <<EOF
    if test -r "\$HOME/.zprofile"; then
      source "\$HOME/.zprofile"
    fi
    EOF

    cat > $out/.zshrc <<EOF
    if test -r "\$HOME/.zshrc"; then
      source "\$HOME/.zshrc"
      HISTFILE="\$HOME/.zsh_history"
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
