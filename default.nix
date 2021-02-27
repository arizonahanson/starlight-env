{ pkgs ? import <nixpkgs> { } }:
let
  cfg = {
    darwin = !isNull (builtins.match ".*darwin$" builtins.currentSystem);
    theme = {
      fg = 15;
      fg-alt = 7;
      bg = 0;
      bg-alt = 8;
      accent = 3;
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
    pkgs = {
      mygit = (import ./nixpkgs/git { inherit cfg pkgs; });
      mytmux = (import ./nixpkgs/tmux { inherit cfg pkgs; });
      myvim = (import ./nixpkgs/vim { inherit cfg pkgs; });
      myzsh = (import ./nixpkgs/zsh { inherit cfg pkgs; });
    };
  };
in
pkgs.stdenv.mkDerivation {
  name = "starlight-env";
  src = ./.;
  EDITOR = "${cfg.pkgs.myvim}/bin/vim";
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
    makeWrapper
    man-db
    nixpkgs-fmt
    nox
    shellcheck
    tree
    units
    universal-ctags
    unzip
    w3m
    xz
    zip
    (cfg.pkgs.mygit)
    (cfg.pkgs.mytmux)
    (cfg.pkgs.myvim)
    (cfg.pkgs.myzsh)
  ];
  installPhase = ''
    makeWrapper "${pkgs.nix}/bin/nix-shell" "$out/bin/dde" --add-flags "$src"
    makeWrapper "${pkgs.nix}/bin/nix-env" "$out/bin/dde-update" \
      --add-flags "-i starlight-env -f https://github.com/isaacwhanson/starlight-env/archive/main.tar.gz"
  '';
  shellHook = ''
    SHELL="${cfg.pkgs.myzsh}/bin/zsh"
    exec "${cfg.pkgs.mytmux}/bin/tmux" -2 new-session -A -s starlight
  '';
}
