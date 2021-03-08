{ cfg, pkgs ? import <nixpkgs> { } }:
let
  mygit =
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
  name = "mygitrc";
  src = ./.;
  buildInputs = [ (mygit) pkgs.makeWrapper ];
  installPhase = ''
    mkdir -p $out/etc
    cat >> $out/etc/gitconfig << EOF
    [include]
      path = ${mygit}/etc/gitconfig
    [core]
      autocrlf = false
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
      filename = ${cfg.theme.path}
      linenumber = ${cfg.theme.bg-alt}
      match = ${cfg.theme.match}
      separator = ${cfg.theme.fg-alt}
    [color "diff"]
      commit = ${cfg.theme.number}
      frag = ${cfg.theme.fg-alt}
      func = ${cfg.theme.function}
      meta = ${cfg.theme.bg-alt}
      new = ${cfg.theme.diff-add}
      newMoved = ${cfg.theme.diff-add-moved}
      old = ${cfg.theme.diff-remove}
      oldMoved = ${cfg.theme.diff-remove-moved}
    [color "branch"]
      current = ${cfg.theme.currentBranch}
      local = ${cfg.theme.localBranch}
      remote = ${cfg.theme.remoteBranch}
    [color "decorate"]
      HEAD = ${cfg.theme.localBranch}
      branch = ${cfg.theme.currentBranch}
      remoteBranch = ${cfg.theme.remoteBranch}
      stash = ${cfg.theme.localBranch}
      tag = ${cfg.theme.remoteBranch}
    [color "remote"]
      hint = ${cfg.theme.fg-alt}
      success = ${cfg.theme.info}
      warning = ${cfg.theme.warning}
      error = ${cfg.theme.error}
    [color "status"]
      header = ${cfg.theme.bg-alt}
      added = ${cfg.theme.staged}
      changed = ${cfg.theme.diff-change}
      untracked = ${cfg.theme.diff-remove}
      branch = ${cfg.theme.currentBranch}
      localBranch = ${cfg.theme.currentBranch}
      remoteBranch = ${cfg.theme.remoteBranch}
    EOF
    cat >> $out/etc/tigrc << EOF
    set line-graphics = auto
    set ignore-case  = smart-case
    color cursor ${cfg.theme.select} ${cfg.theme.bg-alt}
    color status ${cfg.theme.info} default
    color title-focus ${cfg.theme.fg} ${cfg.theme.bg-alt}
    color title-blur ${cfg.theme.bg-alt} default
    color search-result ${cfg.theme.match} ${cfg.theme.bg-alt}
    color delimiter ${cfg.theme.bg-alt} default
    color line-number ${cfg.theme.bg-alt} default
    color id ${cfg.theme.number} default
    color date ${cfg.theme.bg-alt} default
    color directory ${cfg.theme.path} default
    color file ${cfg.theme.path} default
    color graph-commit ${cfg.theme.fg-alt} default
    color palette-0  4  default
    color palette-1  14 default
    color palette-2  5  default
    color palette-3  10 default
    color palette-4  1  default
    color palette-5  11 default
    color palette-6  3  default
    color palette-7  9  default
    color palette-8  2  default
    color palette-9  13 default
    color palette-10 6  default
    color palette-11 12 default
    color palette-12 7  default
    color palette-13 15 default
    color main-head ${cfg.theme.localBranch} default
    color main-tracked ${cfg.theme.currentBranch} default
    color main-remote ${cfg.theme.remoteBranch} default
    color main-tag ${cfg.theme.constant} default
    color main-local-tag ${cfg.theme.constant} default
    color main-ref ${cfg.theme.remoteBranch} default
    color stat-staged ${cfg.theme.staged} default
    color stat-unstaged ${cfg.theme.diff-change} default
    color stat-untracked ${cfg.theme.diff-remove} default
    color diff-header ${cfg.theme.bg-alt} default
    color diff-chunk ${cfg.theme.fg-alt} default
    color diff-stat ${cfg.theme.path} default
    color diff-add ${cfg.theme.diff-add} default
    color diff-add2 ${cfg.theme.diff-add-moved} default
    color diff-del ${cfg.theme.diff-remove} default
    color diff-del2 ${cfg.theme.diff-remove-moved} default
    color diff-index ${cfg.theme.bg-alt} default
    color commit ${cfg.theme.number} default
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
