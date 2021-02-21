{ pkgs ? import <nixpkgs> { } }:
let
  cfg = {
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
    };
  };
  myvim = import ./nixpkgs/vim { inherit cfg pkgs; };
  mygit = import ./nixpkgs/git { inherit pkgs; };
in
pkgs.stdenv.mkDerivation {
  name = "starlight-env";
  src = ./src;
  buildInputs = with pkgs; [
    (myvim)
    (mygit)
    zsh
    coreutils
    ag
    calc
    curl
    fzf
    gcc
    gitAndTools.tig
    gnumake
    gnupg
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
    zip
  ];
  EDITOR = "vim";
  shellHook = "";
}
