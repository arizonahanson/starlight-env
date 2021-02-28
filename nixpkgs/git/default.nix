{ cfg, pkgs ? import <nixpkgs> { } }:

(pkgs.git.overrideAttrs (
  oldAttrs: rec {
    doInstallCheck = false;
    preFixup = ''
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
        [tig "color"]
          cursor = ${toString cfg.theme.select} default
          date = ${toString cfg.theme.bg-alt} default
          graph-commit = ${toString cfg.theme.fg-alt} default
          line-number = ${toString cfg.theme.bg-alt} default
          main-tracked = ${toString cfg.theme.currentBranch} default
          search-result = ${toString cfg.theme.match} default
          status = ${toString cfg.theme.info} default
          title-blur = ${toString cfg.theme.bg-alt} default
          title-focus = ${toString cfg.theme.fg} ${toString cfg.theme.bg-alt}
      EOF
      wrapProgram $out/bin/git --add-flags "-c 'include.path=$out/etc/gitconfig'"
    '';
  }
)).override {
  guiSupport = false;
  pythonSupport = false;
  perlSupport = false;
  withManual = false; # time consuming
  withLibsecret = !cfg.darwin;
}
