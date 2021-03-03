{ pkgs ? import <nixpkgs> { } }:
let
  cfg = {
    url = "https://github.com/isaacwhanson/starlight-env/archive/main.tar.gz";
    theme = {
      fg = "15";
      fg-alt = "7";
      bg = "0";
      bg-alt = "8";
      accent = "3";
      substitution = "7";
      path = "4";
      match = "9";
      string = "3";
      select = "11";
      character = "11";
      number = "14";
      boolean = "5";
      constant = "13";
      executable = "2";
      function = "6";
      type = "4";
      statement = "12";
      pattern = "12";
      keyword = "10";
      error = "1";
      warning = "9";
      info = "11";
      diff-add = "2";
      diff-change = "9";
      diff-remove = "1";
      staged = "11";
      currentBranch = "12";
      socket = "12";
      diff-add-moved = "10";
      diff-remove-moved = "9";
      localBranch = "4";
      remoteBranch = "5";
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
  FZF_TMUX = "1";
  FZF_DEFAULT_COMMAND = "ag -f -g '' --hidden --depth 16 --ignore dosdevices";
  FZF_CTRL_T_COMMAND = "ag -f -g '' --hidden --depth 16 --ignore dosdevices";
  FZF_DEFAULT_OPTS = "-m --ansi --no-bold --color=dark,fg:${cfg.theme.fg},bg:${cfg.theme.bg},hl:${cfg.theme.match},fg+:${cfg.theme.select},bg+:${cfg.theme.bg},hl+:${cfg.theme.match},info:${cfg.theme.bg-alt},border:${cfg.theme.fg-alt},prompt:${cfg.theme.fg-alt},pointer:${cfg.theme.select},marker:${cfg.theme.select},spinner:${cfg.theme.info},header:${cfg.theme.fg-alt} --tac";
  FZF_ALT_C_COMMAND = "find -L . -maxdepth 16 -type d 2>/dev/null";
  GREP_COLORS = "mt=38;5;${cfg.theme.match}:sl=:cx=:fn=38;5;${cfg.theme.path}:ln=38;5;${cfg.theme.bg-alt}:bn=38;5;${cfg.theme.number}:se=38;5;${cfg.theme.fg-alt}";
  # shorter delay on cmd-mode
  KEYTIMEOUT = "1";
  LESS = "-erFX";
  TIGRC_USER = "${cfg.pkgs.mygit}/etc/tigrc";
  nativeBuildInputs = with pkgs; [
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
    less
    makeWrapper
    man-db
    nixpkgs-fmt
    nox
    shellcheck
    tree
    units
    universal-ctags
    unixtools.whereis
    unzip
    w3m
    xz
    zip
    (cfg.pkgs.mygit)
    (cfg.pkgs.mytmux)
    (cfg.pkgs.myvim)
    (cfg.pkgs.myzsh)
    (writeScriptBin "dde-install"
      "${nix}/bin/nix-env -i starlight-env -f ${cfg.url}")
  ];
  installPhase = ''
    makeWrapper "${pkgs.nix}/bin/nix-shell" "$out/bin/dde" --add-flags "${cfg.url}"
  '';
  shellHook = ''
    SHELL="${cfg.pkgs.myzsh}/bin/zsh"
    exec "${cfg.pkgs.mytmux}/bin/tmux" -2 new-session -A -s starlight
  '';
}
