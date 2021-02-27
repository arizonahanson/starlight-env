{ pkgs ? import <nixpkgs> { } }:
let
  cfg = {
    darwin = !isNull (builtins.match ".*darwin$" builtins.currentSystem);
    theme = {
      fg = 15;
      fg-alt = 7;
      bg = 0;
      bg-alt = 8;
      substitution = 7;
      path = 4;
      match = 9;
      string = 3;
      select = 11;
      character = 11;
      number = 14;
      boolean = 5;
      constant = 13;
      function = 6;
      type = 4;
      statement = 12;
      keyword = 10;
      error = 1;
      warning = 9;
      info = 11;
      diff-add = 2;
      diff-change = 9;
      diff-remove = 1;
      staged = 11;
      currentBranch = 12;
      diff-add-moved = 10;
      diff-remove-moved = 9;
      localBranch = 4;
      remoteBranch = 5;
    };
  };
  mygit = (import ./nixpkgs/git { inherit cfg pkgs; });
  myvim = (import ./nixpkgs/vim { inherit cfg pkgs; });
  zdot = (import ./nixpkgs/zdot { inherit cfg pkgs; });
in
pkgs.stdenv.mkDerivation {
  name = "starlight-env";
  src = ./.;
  EDITOR = "${myvim}/bin/vim";
  ZDOTDIR = "${zdot}";
  buildInputs = with pkgs; [
    ag
    calc
    coreutils
    curl
    findutils
    fzf
    gcc
    gitAndTools.tig
    gnumake
    gnupg
    gnused
    gnutar
    man-db
    nixpkgs-fmt
    nox
    shellcheck
    tree
    tmux
    units
    universal-ctags
    unzip
    w3m
    xz
    zip
    zsh
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
    (myvim)
    (mygit)
    (zdot)
  ];
  installPhase = ''
    mkdir -p "$out/src"
    cp -r "$src/." "$out/src/"
    mkdir -p "$out/bin"
    echo "nix-shell $out/src" > $out/bin/dde
    chmod a+x $out/bin/dde
  '';
  shellHook = ''
    SHELL="${pkgs.zsh}/bin/zsh"
    exec "${pkgs.tmux}/bin/tmux" -2 new-session -A -s starlight
  '';
}
