{ pkgs ? import <nixpkgs> { } }:

(pkgs.git.overrideAttrs (
  oldAttrs: rec {
    doInstallCheck = false;
  }
)).override {
  guiSupport = false;
  pythonSupport = false;
  perlSupport = false;
  withManual = false; # time consuming
  withLibsecret = builtins.currentSystem != "darwin";
}
