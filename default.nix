{ config ? { }, pkgs ? import <nixpkgs> { } }:
let
  cfg = {
    url = "https://github.com/arizonahanson/starlight-env/archive/main.tar.gz";
    theme = {
      fg = "15";
      fg-alt = "7";
      bg = "0";
      bg-alt = "8";
      accent = "12";
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
      javalsp = (import ./nixpkgs/javalsp { inherit cfg pkgs; });
      silq = (import ./nixpkgs/silq { inherit cfg pkgs; });
      azsh-shell = pkgs.writeScriptBin "azsh-shell" ''
        nix-shell $@
      '';
      azsh-from = pkgs.writeScriptBin "azsh-from" ''
        nix-channel --update
        nix-env -u
        nix-env -i azsh -f "$1"
      '';
      palette = pkgs.writeScriptBin "palette" ''
        #!/usr/bin/env zsh
        for bold in 0 1; do
          for col in {0..7}; do
            echo -en "\e[$bold;3''${col}m $(printf '%X' $((col+bold*8))) "
          done; echo
        done; echo
        for col in 2 6 4 5 1 3 0 7; do
          echo -en "\e[0;3''${col}m \e[1;3''${col}m "
        done; echo
        for col in 2 6 4 5 1 3 0 7; do
          echo -en "\e[0;3''${col}m$(printf '%X' $col) \e[1;3''${col}m$(printf '%X' $((col+8))) "
        done; echo
      '';
      git-all = pkgs.writeScriptBin "git-all" ''
        echo
        for repo in $(find -L . -maxdepth 7 -iname '.git' -type d -printf '%P\0' 2>/dev/null | xargs -0 dirname | sort); do
          echo -e "\e[38;5;${cfg.theme.executable}m \e[38;5;${cfg.theme.path}m$repo \e[0m(\e[38;5;${cfg.theme.function}m$@\e[0m)"
          pushd $repo >/dev/null
          ${cfg.pkgs.mygit}/bin/git "$@"
          popd >/dev/null
          echo
        done
      '';
    };
  };
in
pkgs.stdenv.mkDerivation {
  name = "azsh";
  src = ./.;
  dontMakeSourcesWritable = 1;
  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;
  dontStrip = true;
  dontPatchELF = true;
  dontPruneLibtoolFiles = true;
  # environment variables
  EDITOR = "${cfg.pkgs.myvim}/bin/vim";
  FZF_TMUX = "1";
  FZF_ALT_C_COMMAND = "${pkgs.findutils}/bin/find -L . -maxdepth 16 -type d 2>/dev/null";
  FZF_CTRL_T_COMMAND = "${pkgs.ag}/bin/ag -f -g '' --hidden --depth 16 --ignore dosdevices";
  FZF_DEFAULT_COMMAND = "${pkgs.ag}/bin/ag -f -g '' --hidden --depth 16 --ignore dosdevices";
  FZF_DEFAULT_OPTS = "-m --ansi --no-bold --color=dark,fg:${cfg.theme.fg},bg:${cfg.theme.bg},hl:${cfg.theme.match},fg+:${cfg.theme.select},bg+:${cfg.theme.bg},hl+:${cfg.theme.match},info:${cfg.theme.bg-alt},border:${cfg.theme.fg-alt},prompt:${cfg.theme.fg-alt},pointer:${cfg.theme.select},marker:${cfg.theme.select},spinner:${cfg.theme.info},header:${cfg.theme.fg-alt} --tac";
  GREP_COLORS = "mt=38;5;${cfg.theme.match}:sl=:cx=:fn=38;5;${cfg.theme.path}:ln=38;5;${cfg.theme.bg-alt}:bn=38;5;${cfg.theme.number}:se=38;5;${cfg.theme.fg-alt}";
  KEYTIMEOUT = "1"; # shorter zsh cmd-mode delay
  LESS = "-erFX";
  TIGRC_USER = "${cfg.pkgs.mygit}/etc/tigrc";
  # packages
  propagatedBuildInputs = with pkgs; [
    ag
    calc
    (lowPrio toybox)
    coreutils
    ctags
    curl
    findutils
    fzf
    gitAndTools.tig
    gnupg
    gnused
    gnutar
    go
    less
    makeWrapper
    man-db
    nixpkgs-fmt
    nox
    shellcheck
    tree
    units
    unixtools.whereis
    unzip
    w3m
    xz
    zip
    (cfg.pkgs.azsh-from)
    (cfg.pkgs.git-all)
    (cfg.pkgs.mygit)
    (cfg.pkgs.mytmux)
    (cfg.pkgs.myvim)
    (cfg.pkgs.myzsh)
    (cfg.pkgs.palette)
    (writeScriptBin "azsh-install" "${cfg.pkgs.azsh-from}/bin/azsh-from $src")
  ] ++ pkgs.lib.optional (!pkgs.stdenv.isDarwin) cfg.pkgs.silq;
  # entry point tmux session
  shellHook = ''
    exec "${cfg.pkgs.mytmux}/bin/tmux" -2 new-session -A -s mytmux
  '';
  # nix-shell wrapper "azsh"
  installPhase = ''
    makeWrapper "${cfg.pkgs.azsh-shell}/bin/azsh-shell" "$out/bin/azsh" --add-flags "$src"
    makeWrapper "${cfg.pkgs.azsh-from}/bin/azsh-from" "$out/bin/azsh-update" --add-flags "${cfg.url}"
  '';
}
