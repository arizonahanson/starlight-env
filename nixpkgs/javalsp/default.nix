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
    sha256 = "1zsdm266jwmjbffd6cahlvlkw2cq7lq1qxnpd3bibpbgc4f45vif";
    leaveDotGit = true;
  };
  buildInputs = with pkgs; [
    (cfg.pkgs.mygit)
    makeWrapper
    adoptopenjdk-hotspot-bin-13
    maven
    nodejs
    protobuf
  ];
  configureScript = ":";
  buildPhase = ''
    mkdir -p $out
    cp -r $src $out/src
    chmod -R ug+rw $out/src
    cd $out/src
    export HOME=$out/src
    npm config set cache $out/src
    npm install
    ./scripts/gen_proto.sh
    ./scripts/format.sh
    export JAVA_HOME="${pkgs.adoptopenjdk-hotspot-bin-13}";
    $JAVA_HOME/bin/jlink \
      --add-modules java.base,java.compiler,java.logging,java.sql,java.xml,jdk.compiler,jdk.jdi,jdk.unsupported,jdk.zipfs \
      --output dist/${platform} \
      --no-header-files \
      --no-man-pages \
      --compress 2
    mvn package -DskipTests -Dmaven.repo.local=$out/src/.m2
  '';
  installPhase = ''
    mkdir -p $out/libexec
    cp -r $out/src/dist/*${platform}.sh $out/libexec/
    cp -r $out/src/dist/${platform} $out/libexec/
    cp -r $out/src/dist/classpath $out/libexec/
    makeWrapper $out/libexec/lang_server_${platform}.sh $out/bin/lang_server
    rm -r $out/src
  '';
}
