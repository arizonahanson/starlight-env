{ cfg, pkgs ? import <nixpkgs> { } }:
let
  platform = if pkgs.stdenv.isDarwin then "mac" else "linux";
in
pkgs.stdenv.mkDerivation {
  name = "javalsp";
  src = pkgs.fetchFromGitHub {
    owner = "georgewfraser";
    repo = "java-language-server";
    rev = "v0.2.32";
    sha256 = "1yirzpj74ngzv53zdypq8xrca6450b6nr08ivxczifcl8p1b7jkx";
    leaveDotGit = true;
  };
  buildInputs = with pkgs; [
    (cfg.pkgs.mygit)
    makeWrapper
    adoptopenjdk-hotspot-bin-13
    maven
    protobuf
    nodejs
  ];
  JAVA_HOME = "${pkgs.adoptopenjdk-hotspot-bin-13}/Contents/Home";
  configureScript = ":";
  buildPhase = ''
    HOME=$out
    mkdir -pv $out/src
    cp -r $src/* $out/src/
    cd $out/src
    npm install
    #./scripts/link_${platform}.sh
    #./scripts/format.sh
    mvn package -DskipTests
  '';
  installPhase = ''
    cp -r $src/src/dist $out/
    rm -r $src/src
    makeWrapper $out/lang_server_${platform}.sh $out/bin/lang_server
  '';
}
