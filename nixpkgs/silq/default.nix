{ cfg, pkgs ? import <nixpkgs> { } }:

let
  setup = pkgs.writeScript "setup" ''
    mkdir -p "$ANGBAND_PATH"
    # Copy all the data files into place
    cp -ar $1/* "$ANGBAND_PATH"
    # The copied files are not writable, make them so
    chmod +w -R "$ANGBAND_PATH"
  '';
in
pkgs.stdenv.mkDerivation {
  name = "sil-q";
  src = pkgs.fetchFromGitHub {
    owner = "sil-quirk";
    repo = "sil-q";
    rev = "refs/tags/v1.4.2";
    sha256 = "0m1vikjpivg06vxriw952knh9cyhfk8y3fvmrkfv9958mzyyf6cl";
  };
  dontPatch = true;
  configurePhase = ''
    sed -i 's/^CFLAGS.*/CFLAGS=-Wall -O1 -pipe -g -D"USE_GCU" -D"USE_NCURSES"/' src/Makefile.std
    sed -i 's/^LIBS.*/LIBS=-lncurses/' src/Makefile.std
  '';
  nativeBuildInputs = [ pkgs.makeWrapper ];
  buildInputs = [ pkgs.ncurses ];
  buildPhase = ''
    cd src
    make -f Makefile.std
  '';
  installPhase = ''
    make install -f Makefile.std
    cd ..
    mkdir -p $out/bin
    cp sil $out/bin/silq
    wrapProgram $out/bin/silq \
      --run "set -u" \
      --run "export ANGBAND_PATH=\$XDG_CONFIG_HOME/silq" \
      --run "${setup} $src" \
      --run "cd \$ANGBAND_PATH"
  '';
}
