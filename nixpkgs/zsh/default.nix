{ cfg, pkgs ? import <nixpkgs> { } }:

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
    #eval \$(dircolors -b /etc/dircolors)
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
    ZSH_THEME="robbyrussell"
    plugins=(git colored-man-pages)
    source \$ZSH/oh-my-zsh.sh
    source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    fpath=(${pkgs.zsh-completions}/share/zsh/site-functions ${pkgs.nix-zsh-completions}/share/zsh/site-functions \$fpath)
    if test -r "\$HOME/.zshrc"; then
      source "\$HOME/.zshrc"
    fi
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
