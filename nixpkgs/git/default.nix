{ cfg, pkgs ? import <nixpkgs> { } }:

let mygit =
  (pkgs.git.overrideAttrs (
    oldAttrs: rec {
      doInstallCheck = false;
      osxkeychainSupport = pkgs.stdenv.isDarwin;
    }
  )).override {
    guiSupport = false;
    pythonSupport = false;
    perlSupport = false;
    withManual = false; # time consuming
    withLibsecret = !pkgs.stdenv.isDarwin;
  };
in
pkgs.stdenv.mkDerivation {
  name = "mygit";
  src = ./.;
  buildInputs = [ (mygit) pkgs.makeWrapper ];
  installPhase = ''
    mkdir -p $out/etc
    cat >> $out/etc/gitconfig << EOF
    [core]
      autocrlf = false
      filemode = true
    [diff]
      algorithm = minimal
      colorMoved = blocks
      colorMovedWS = allow-indentation-change
      tool = vimdiff3
    [difftool]
      prompt = true
    [fetch]
      prune = true
      pruneTags = true
    [help]
      autocorrect = 30
      format = html
      htmlpath = "https://git-scm.com/docs"
    [merge]
      conflictstyle = diff3
      tool = vimdiff
    [mergetool]
      keepBackup = false
      prompt = false
    [pack]
      threads = 2
    [pull]
      ff = only
    [push]
      default = current
      followTags = true
    [color]
      ui = auto
    [color "grep"]
      filename = ${toString cfg.theme.path}
      linenumber = ${toString cfg.theme.bg-alt}
      match = ${toString cfg.theme.match}
      separator = ${toString cfg.theme.fg-alt}
    [color "diff"]
      commit = ${toString cfg.theme.fg-alt}
      frag = ${toString cfg.theme.fg-alt}
      meta = ${toString cfg.theme.bg-alt}
      new = ${toString cfg.theme.diff-add}
      newMoved = ${toString cfg.theme.diff-add-moved}
      old = ${toString cfg.theme.diff-remove}
      oldMoved = ${toString cfg.theme.diff-remove-moved}
    [color "branch"]
      current = ${toString cfg.theme.currentBranch}
      local = ${toString cfg.theme.localBranch}
      remote = ${toString cfg.theme.remoteBranch}
    [color "decorate"]
      HEAD = ${toString cfg.theme.localBranch}
      branch = ${toString cfg.theme.currentBranch}
      remoteBranch = ${toString cfg.theme.remoteBranch}
      stash = ${toString cfg.theme.localBranch}
      tag = ${toString cfg.theme.remoteBranch}
    [color "remote"]
      hint = ${toString cfg.theme.fg-alt}
      success = ${toString cfg.theme.info}
      warning = ${toString cfg.theme.warning}
      error = ${toString cfg.theme.error}
    [color "status"]
      header = ${toString cfg.theme.bg-alt}
      added = ${toString cfg.theme.staged}
      changed = ${toString cfg.theme.diff-change}
      untracked = ${toString cfg.theme.diff-remove}
      branch = ${toString cfg.theme.currentBranch}
      localBranch = ${toString cfg.theme.currentBranch}
      remoteBranch = ${toString cfg.theme.remoteBranch}
    EOF
    cat >> $out/etc/tigrc << EOF
    color cursor ${toString cfg.theme.select} default
    color date ${toString cfg.theme.bg-alt} default
    color graph-commit ${toString cfg.theme.fg-alt} default
    color line-number ${toString cfg.theme.bg-alt} default
    color main-tracked ${toString cfg.theme.currentBranch} default
    color search-result ${toString cfg.theme.match} default
    color status ${toString cfg.theme.info} default
    color title-blur ${toString cfg.theme.bg-alt} default
    color title-focus ${toString cfg.theme.fg} ${toString cfg.theme.bg-alt}
    bind generic h scroll-left
    bind generic j move-down
    bind generic k move-up
    bind generic l scroll-right
    bind generic g  none
    bind generic gg move-first-line
    bind generic gj next
    bind generic gk previous
    bind generic gp parent
    bind generic gP back
    bind generic gn view-next
    bind main    G move-last-line
    bind generic G move-last-line
    bind generic <C-f> move-page-down
    bind generic <C-b> move-page-up
    bind generic v  none
    bind generic vm view-main
    bind generic vd view-diff
    bind generic vl view-log
    bind generic vt view-tree
    bind generic vb view-blob
    bind generic vx view-blame
    bind generic vr view-refs
    bind generic vs view-status
    bind generic vu view-stage
    bind generic vy view-stash
    bind generic vg view-grep
    bind generic vp view-pager
    bind generic vh view-help
    bind generic o  none
    bind generic oo :toggle sort-order
    bind generic os :toggle sort-field
    bind generic on :toggle line-number
    bind generic od :toggle date
    bind generic oa :toggle author
    bind generic og :toggle line-graphics
    bind generic of :toggle file-name
    bind generic op :toggle ignore-space
    bind generic oi :toggle id
    bind generic ot :toggle commit-title-overflow
    bind generic oF :toggle file-filter
    bind generic or :toggle commit-title-refs
    bind generic @  none
    bind generic @j :/^@@
    bind generic @k :?^@@
    bind generic @- :toggle diff-context -1
    bind generic @+ :toggle diff-context +1
    bind status  u  none
    bind stage   u  none
    bind generic uu status-update
    bind generic ur status-revert
    bind generic um status-merge
    bind generic ul stage-update-line
    bind generic up stage-update-part
    bind generic us stage-split-chunk
    bind generic c  none
    bind generic cc !?git commit -a
    bind generic ca !?@git commit --amend
    bind generic cp !?@git push -u
    bind generic K view-help
    bind generic <C-w><C-w> view-next
    EOF
    makeWrapper ${mygit}/bin/git $out/bin/git --add-flags "-c 'include.path=$out/etc/gitconfig'"
  '';
}

