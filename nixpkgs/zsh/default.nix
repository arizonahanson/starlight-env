{ cfg, pkgs ? import <nixpkgs> { } }:
let
  dircolors = pkgs.writeTextFile {
    name = "dircolors";
    destination = "/etc/dircolors";
    text = ''
      BLK                   38;5;${cfg.theme.string}
      CAPABILITY            38;5;17
      CHR                   38;5;${cfg.theme.character}
      DIR                   38;5;${cfg.theme.path}
      DOOR                  38;5;127
      EXEC                  38;5;${cfg.theme.executable}
      FIFO                  38;5;126
      FILE                  0
      LINK                  target
      MULTIHARDLINK         38;5;222;1
      # "NORMAL don't reset the bold attribute -
      # https://github.com/trapd00r/LS_COLORS/issues/11
      #NORMAL                38;5;254
      NORMAL                0
      ORPHAN                48;5;196;38;5;232;1
      OTHER_WRITABLE        38;5;220;1
      SETGID                48;5;3;38;5;0
      SETUID                38;5;220;1;3;100;1
      SOCK                  38;5;${cfg.theme.socket}
      STICKY                38;5;86;48;5;234
      STICKY_OTHER_WRITABLE 48;5;235;38;5;139;3
      # documents {{{1
      *README               38;5;${cfg.theme.fg}
      *README.rst           38;5;${cfg.theme.fg}
      *README.md            38;5;${cfg.theme.fg}
      *LICENSE              38;5;${cfg.theme.fg}
      *COPYING              38;5;${cfg.theme.fg}
      *INSTALL              38;5;${cfg.theme.fg}
      *COPYRIGHT            38;5;${cfg.theme.fg}
      *AUTHORS              38;5;${cfg.theme.fg}
      *CONTRIBUTORS         38;5;${cfg.theme.fg}
      *PATENTS              38;5;${cfg.theme.fg}
      *VERSION              38;5;${cfg.theme.fg}
      *NOTICE               38;5;${cfg.theme.fg}
      *CHANGES              38;5;${cfg.theme.fg}
      # plain-text {{{2
      .log                  38;5;${cfg.theme.fg-alt}
      .txt                  38;5;${cfg.theme.fg-alt}
      # markup {{{2
      .adoc                 38;5;${cfg.theme.fg}
      .asciidoc             38;5;${cfg.theme.fg}
      .etx                  38;5;${cfg.theme.fg}
      .info                 38;5;${cfg.theme.fg}
      .markdown             38;5;${cfg.theme.fg}
      .md                   38;5;${cfg.theme.fg}
      .mkd                  38;5;${cfg.theme.fg}
      .nfo                  38;5;${cfg.theme.fg}
      .pod                  38;5;${cfg.theme.fg}
      .rst                  38;5;${cfg.theme.fg}
      .tex                  38;5;${cfg.theme.fg}
      .textile              38;5;${cfg.theme.fg}
      # key-value, non-relational data {{{2
      .bib                  38;5;${cfg.theme.string}
      .json                 38;5;${cfg.theme.string}
      .jsonl                38;5;${cfg.theme.string}
      .jsonnet              38;5;${cfg.theme.string}
      .libsonnet            38;5;${cfg.theme.string}
      .ndjson               38;5;${cfg.theme.string}
      .msg                  38;5;${cfg.theme.string}
      .pgn                  38;5;${cfg.theme.string}
      .rss                  38;5;${cfg.theme.string}
      .xml                  38;5;${cfg.theme.string}
      .fxml                 38;5;${cfg.theme.string}
      .toml                 38;5;${cfg.theme.string}
      .yaml                 38;5;${cfg.theme.string}
      .yml                  38;5;${cfg.theme.string}
      .RData                38;5;${cfg.theme.string}
      .rdata                38;5;${cfg.theme.string}
      .xsd                  38;5;${cfg.theme.string}
      .dtd                  38;5;${cfg.theme.string}
      .sgml                 38;5;${cfg.theme.string}
      .rng                  38;5;${cfg.theme.string}
      .rnc                  38;5;${cfg.theme.string}
      # }}}
      # binary {{{2
      .cbr                  38;5;141
      .cbz                  38;5;141
      .chm                  38;5;141
      .djvu                 38;5;141
      .pdf                  38;5;141
      .PDF                  38;5;141
      .mobi                 38;5;141
      .epub                 38;5;141
      # words {{{3
      .docm                 38;5;111;4
      .doc                  38;5;111
      .docx                 38;5;111
      .odb                  38;5;111
      .odt                  38;5;111
      .rtf                  38;5;111
      # presentation {{{3
      .odp                  38;5;166
      .pps                  38;5;166
      .ppt                  38;5;166
      .pptx                 38;5;166
      #   Powerpoint show
      .ppts                 38;5;166
      #   Powerpoint with enabled macros
      .pptxm                38;5;166;4
      #   Powerpoint show with enabled macros
      .pptsm                38;5;166;4
      # spreadsheet {{{3
      .csv                  38;5;78
      .tsv                  38;5;78
      #   Open document spreadsheet
      .ods                  38;5;112
      .xla                  38;5;76
      #   Excel spreadsheet
      .xls                  38;5;112
      .xlsx                 38;5;112
      #   Excel spreadsheet with macros
      .xlsxm                38;5;112;4
      #   Excel module
      .xltm                 38;5;73;4
      .xltx                 38;5;73
      #   macOS office suite {{{3
      .pages                38;5;111
      .numbers              38;5;112
      .key                  38;5;166
      # }}}
      # }}}
      # configs {{{2
      *config               1
      *cfg                  1
      *conf                 1
      *rc                   1
      *authorized_keys      1
      *known_hosts          1
      .ini                  1
      .plist                1
      #   vim
      .viminfo              1
      #   cisco VPN client configuration
      .pcf                  1
      #   adobe photoshop proof settings file
      .psf                  1
      #   Sublime Text config
      .hidden-color-scheme  1
      .hidden-tmTheme       1
      .last-run             1
      .merged-ca-bundle     1
      .sublime-build        1
      .sublime-commands     1
      .sublime-keymap       1
      .sublime-settings     1
      .sublime-snippet      1
      .sublime-project      1
      .sublime-workspace    1
      .tmTheme              1
      .user-ca-bundle       1
      # eclipse
      .epf                  1
      # }}}
      # }}}
      # code {{{1
      # version control {{{2
      .git                  38;5;197
      .gitignore            38;5;240
      .gitattributes        38;5;240
      .gitmodules           38;5;240

      # shell {{{2
      .awk                  38;5;172
      .bash                 38;5;172
      .bat                  38;5;172
      .BAT                  38;5;172
      .sed                  38;5;172
      .sh                   38;5;172
      .zsh                  38;5;172
      .vim                  38;5;172
      .kak                  38;5;172

      # interpreted {{{2
      .ahk                  38;5;41
      # python
      .py                   38;5;41
      .ipynb                38;5;41
      # ruby
      .rb                   38;5;41
      .gemspec              38;5;41
      # perl
      .pl                   38;5;208
      .PL                   38;5;160
      .t                    38;5;114
      # sql
      .msql                 38;5;222
      .mysql                38;5;222
      .pgsql                38;5;222
      .sql                  38;5;222
      #   Tool Command Language
      .tcl                  38;5;64;1
      # R language
      .r                    38;5;49
      .R                    38;5;49
      # GrADS script
      .gs                   38;5;81
      # Clojure
      .clj                  38;5;41
      .cljs                 38;5;41
      .cljc                 38;5;41
      # Clojure gorilla REPL worksheet
      .cljw                 38;5;41
      # Scala
      .scala                38;5;41
      .sc                   38;5;41
      # Dart
      .dart                 38;5;51

      # compiled {{{2
      #
      #   assembly language
      .asm                  38;5;81
      #   LISP
      .cl                   38;5;81
      .lisp                 38;5;81
      .rkt                  38;5;81
      #   lua
      .lua                  38;5;81
      #   Moonscript
      .moon                 38;5;81
      #   C
      .c                    38;5;81
      .C                    38;5;81
      .h                    38;5;110
      .H                    38;5;110
      .tcc                  38;5;110
      #   C++
      .c++                  38;5;81
      .h++                  38;5;110
      .hpp                  38;5;110
      .hxx                  38;5;110
      .ii                   38;5;110
      #   method file for Objective C
      .M                    38;5;110
      .m                    38;5;110
      #   Csharp
      .cc                   38;5;81
      .cs                   38;5;81
      .cp                   38;5;81
      .cpp                  38;5;81
      .cxx                  38;5;81
      #   Crystal
      .cr                   38;5;81
      #   Google golang
      .go                   38;5;81
      #   fortran
      .f                    38;5;81
      .F                    38;5;81
      .for                  38;5;81
      .ftn                  38;5;81
      .f90                  38;5;81
      .F90                  38;5;81
      .f95                  38;5;81
      .F95                  38;5;81
      .f03                  38;5;81
      .F03                  38;5;81
      .f08                  38;5;81
      .F08                  38;5;81
      # Nim
      .nim                  38;5;81
      .nimble               38;5;81
      #   pascal
      .s                    38;5;110
      .S                    38;5;110
      #   Rust
      .rs                   38;5;81
      #   AppleScript
      .scpt                 38;5;219
      #   Swift
      .swift                38;5;219
      #   ?
      .sx                   38;5;81
      # Vala
      .vala                 38;5;81
      .vapi                 38;5;81
      #   interface file in GHC - https://github.com/trapd00r/LS_COLORS/pull/9
      .hi                   38;5;110
      #   haskell
      .hs                   38;5;81
      .lhs                  38;5;81
      #   agda
      .agda                 38;5;81
      .lagda                38;5;81
      .lagda.tex            38;5;81
      .lagda.rst            38;5;81
      .lagda.md             38;5;81
      .agdai                38;5;110
      #   Zig
      .zig                  38;5;81
      # V
      .v                    38;5;81

      # binaries {{{2
      # compiled apps for interpreted languages
      .pyc                  38;5;240
      # }}}
      # orchestration {{{2
      .tf                   38;5;168
      .tfstate              38;5;168
      .tfvars               38;5;168
      # orchestration 2}}}
      # html {{{2
      .css                  38;5;125;1
      .less                 38;5;125;1
      .sass                 38;5;125;1
      .scss                 38;5;125;1
      .htm                  38;5;125;1
      .html                 38;5;125;1
      .jhtm                 38;5;125;1
      .mht                  38;5;125;1
      .eml                  38;5;125;1
      .mustache             38;5;125;1
      # }}}
      # java {{{2
      .coffee               38;5;10
      .java                 38;5;10
      .mjs                  38;5;10
      .jsm                  38;5;10
      .jsp                  38;5;10
      .js                   38;5;10
      .jsx                  38;5;10
      # }}}
      # php {{{2
      .php                  38;5;81
      #   CakePHP view scripts and helpers
      .ctp                  38;5;81
      #   Twig template engine
      .twig                 38;5;81
      # }}}
      # vb/a {{{2
      .vb                   38;5;81
      .vba                  38;5;81
      .vbs                  38;5;81
      # 2}}}
      # Build stuff {{{2
      *Dockerfile           38;5;155
      .dockerignore         38;5;240
      *Makefile             38;5;155
      *MANIFEST             38;5;243
      *pm_to_blib           38;5;240
      # Functional Configuration
      .nix                  38;5;155
      .dhall                38;5;178
      # ruby rake
      .rake                 38;5;155
      # automake
      .am                   38;5;242
      .in                   38;5;242
      .hin                  38;5;242
      .scan                 38;5;242
      .m4                   38;5;242
      .old                  38;5;242
      .out                  38;5;242
      .SKIP                 38;5;244
      # }}}
      # patch files {{{2
      .diff                 48;5;197;38;5;232
      .patch                48;5;197;38;5;232;1
      #}}}
      # graphics {{{1
      .bmp                  38;5;12
      .dicom                38;5;12
      .tiff                 38;5;12
      .tif                  38;5;12
      .TIFF                 38;5;12
      .cdr                  38;5;12
      .flif                 38;5;12
      .gif                  38;5;12
      .icns                 38;5;12
      .ico                  38;5;12
      .jpeg                 38;5;12
      .JPG                  38;5;12
      .jpg                  38;5;12
      .nth                  38;5;12
      .png                  38;5;12
      .psd                  38;5;12
      .pxd                  38;5;12
      .pxm                  38;5;12
      .xpm                  38;5;12
      .webp                 38;5;12
      # }}}
      # vector {{{1
      .ai                   38;5;99
      .eps                  38;5;99
      .epsf                 38;5;99
      .drw                  38;5;99
      .ps                   38;5;99
      .svg                  38;5;99
      # }}}
      # video {{{1
      .avi                  38;5;114
      .divx                 38;5;114
      .IFO                  38;5;114
      .m2v                  38;5;114
      .m4v                  38;5;114
      .mkv                  38;5;114
      .MOV                  38;5;114
      .mov                  38;5;114
      .mp4                  38;5;114
      .mpeg                 38;5;114
      .mpg                  38;5;114
      .ogm                  38;5;114
      .rmvb                 38;5;114
      .sample               38;5;114
      .wmv                  38;5;114
        # mobile/streaming {{{2
      .3g2                  38;5;115
      .3gp                  38;5;115
      .gp3                  38;5;115
      .webm                 38;5;115
      .gp4                  38;5;115
      .asf                  38;5;115
      .flv                  38;5;115
      .ts                   38;5;115
      .ogv                  38;5;115
      .f4v                  38;5;115
        # }}}
        # lossless {{{2
      .VOB                  38;5;115;1
      .vob                  38;5;115;1
      # }}}
      # subtitles {{{1
      .ass                  38;5;117
      .srt                  38;5;117
      .ssa                  38;5;117
      .sub                  38;5;117
      .sup                  38;5;117 # bitmap image track
      .vtt                  38;5;117
      #}}}
      # audio {{{1
      .3ga                  38;5;137;1
      .S3M                  38;5;137;1
      .aac                  38;5;137;1
      .amr                  38;5;137;1
      .au                   38;5;137;1
      .caf                  38;5;137;1
      .dat                  38;5;137;1
      .dts                  38;5;137;1
      .fcm                  38;5;137;1
      .m4a                  38;5;137;1
      .mod                  38;5;137;1
      .mp3                  38;5;137;1
      .mp4a                 38;5;137;1
      .oga                  38;5;137;1
      .ogg                  38;5;137;1
      .opus                 38;5;137;1
      .s3m                  38;5;137;1
      .sid                  38;5;137;1
      .wma                  38;5;137;1
      # lossless
      .ape                  38;5;136;1
      .aiff                 38;5;136;1
      .cda                  38;5;136;1
      .flac                 38;5;136;1
      .alac                 38;5;136;1
      .mid                  38;5;136;1
      .midi                 38;5;136;1
      .pcm                  38;5;136;1
      .wav                  38;5;136;1
      .wv                   38;5;136;1
      .wvc                  38;5;136;1

      # }}}
      # fonts {{{1
      .afm                  38;5;66
      .fon                  38;5;66
      .fnt                  38;5;66
      .pfb                  38;5;66
      .pfm                  38;5;66
      .ttf                  38;5;66
      .otf                  38;5;66
      # Web Open Font Format
      .woff                 38;5;66
      .woff2                38;5;66
      #   postscript fonts
      .PFA                  38;5;66
      .pfa                  38;5;66
      # }}}
      # archives {{{1
      .7z                   38;5;9
      .a                    38;5;9
      .arj                  38;5;9
      .bz2                  38;5;9
      .cpio                 38;5;9
      .gz                   38;5;9
      .lrz                  38;5;9
      .lz                   38;5;9
      .lzma                 38;5;9
      .lzo                  38;5;9
      .rar                  38;5;9
      .s7z                  38;5;9
      .sz                   38;5;9
      .tar                  38;5;9
      .tgz                  38;5;9
      .warc                 38;5;9
      .xz                   38;5;9
      .z                    38;5;9
      .zip                  38;5;9
      .zipx                 38;5;9
      .zoo                  38;5;9
      .zpaq                 38;5;9
      .zst                  38;5;9
      .zstd                 38;5;9
      .zz                   38;5;9
        # packaged apps {{{2
      .apk                  38;5;215
      .ipa                  38;5;215
      .deb                  38;5;215
      .rpm                  38;5;215
      .jad                  38;5;215
      .jar                  38;5;215
      .cab                  38;5;215
      .pak                  38;5;215
      .pk3                  38;5;215
      .vdf                  38;5;215
      .vpk                  38;5;215
      .bsp                  38;5;215
      .dmg                  38;5;215
      .crx                  38;5;215 # Google Chrome extension
      .xpi                  38;5;215 # Mozilla Firefox extension
        # }}}
        # segments from 0 to three digits after first extension letter {{{2
      .r[0-9]{0,2}          38;5;239
      .zx[0-9]{0,2}         38;5;239
      .z[0-9]{0,2}          38;5;239
      # partial files
      .part                 38;5;239
        # }}}
      # partition images {{{2
      .iso                  38;5;124
      .bin                  38;5;124
      .nrg                  38;5;124
      .qcow                 38;5;124
      .sparseimage          38;5;124
      .toast                38;5;124
      .vcd                  38;5;124
      .vmdk                 38;5;124
      # }}}
      # databases {{{2
      .accdb                38;5;60
      .accde                38;5;60
      .accdr                38;5;60
      .accdt                38;5;60
      .db                   38;5;60
      .fmp12                38;5;60
      .fp7                  38;5;60
      .localstorage         38;5;60
      .mdb                  38;5;60
      .mde                  38;5;60
      .sqlite               38;5;60
      .typelib              38;5;60
      # NetCDF database
      .nc                   38;5;60
      # }}}
      # tempfiles {{{1
      # undo files
      .pacnew               38;5;33
      .un~                  38;5;241
      .orig                 38;5;241
      # backups
      .BUP                  38;5;241
      .bak                  38;5;241
      .o                    38;5;241 #   *nix Object file (shared libraries, core dumps etc)
      *core                 38;5;241 #   Linux user core dump file (from /proc/sys/kernel/core_pattern)
      .mdump                38;5;241 #   Mini DuMP crash report
      .rlib                 38;5;241 #   Static rust library
      .dll                  38;5;241 #   dynamic linked library
      # temporary files
      .swp                  38;5;244
      .swo                  38;5;244
      .tmp                  38;5;244
      .sassc                38;5;244
      # state files
      .pid                  38;5;248
      .state                38;5;248
      *lockfile             38;5;248
      *lock                 38;5;248
      # error logs
      .err                  38;5;160;1
      .error                38;5;160;1
      .stderr               38;5;160;1
      # state dumps
      .aria2                38;5;241
      .dump                 38;5;241
      .stackdump            38;5;241
      .zcompdump            38;5;241
      .zwc                  38;5;241
      # tcpdump, network traffic capture
      .pcap                 38;5;29
      .cap                  38;5;29
      .dmp                  38;5;29
      # macOS
      .DS_Store             38;5;239
      .localized            38;5;239
      .CFUserTextEncoding   38;5;239
      # }}}
      # hosts {{{1
      # /etc/hosts.{deny,allow}
      .allow                38;5;112
      .deny                 38;5;196
      # }}}
      # systemd {{{1
      # http://www.freedesktop.org/software/systemd/man/systemd.unit.html
      .service              38;5;45
      *@.service            38;5;45
      .socket               38;5;45
      .swap                 38;5;45
      .device               38;5;45
      .mount                38;5;45
      .automount            38;5;45
      .target               38;5;45
      .path                 38;5;45
      .timer                38;5;45
      .snapshot             38;5;45
      # }}}
      # metadata {{{1
      .application          38;5;116
      .cue                  38;5;116
      .description          38;5;116
      .directory            38;5;116
      .m3u                  38;5;116
      .m3u8                 38;5;116
      .md5                  38;5;116
      .properties           38;5;116
      .sfv                  38;5;116
      .theme                38;5;116
      .torrent              38;5;116
      .urlview              38;5;116
      .webloc               38;5;116
      .lnk                  38;5;39
      # }}}
      # macOS files {{{1
      *CodeResources        38;5;239 # code signing apps
      *PkgInfo              38;5;239 # app bundle id
      .nib                  38;5;57  # UI
      .car                  38;5;57  # asset catalog
      .dylib                38;5;241 # shared lib
      #   Xcode files {{{2
      .entitlements         1
      .pbxproj              1
      .strings              1
      .storyboard           38;5;196
      .xcconfig             1
      .xcsettings           1
      .xcuserstate          1
      .xcworkspacedata      1
      .xib                  38;5;208
      # }}}
      # }}}
      # encrypted data {{{1
      .asc                  38;5;192;3
      .bfe                  38;5;192;3
      .enc                  38;5;192;3
      .gpg                  38;5;192;3
      .signature            38;5;192;3
      .sig                  38;5;192;3
      .p12                  38;5;192;3
      .pem                  38;5;192;3
      .pgp                  38;5;192;3
      .p7s                  38;5;192;3
      *id_dsa                38;5;192;3
      *id_rsa                38;5;192;3
      *id_ecdsa              38;5;192;3
      *id_ed25519            38;5;192;3
      # 1}}}
      # emulators {{{1
      .32x                  38;5;213
      .cdi                  38;5;213
      .fm2                  38;5;213
      .rom                  38;5;213
      .sav                  38;5;213
      .st                   38;5;213
        # atari
      .a00                  38;5;213
      .a52                  38;5;213
      .A64                  38;5;213
      .a64                  38;5;213
      .a78                  38;5;213
      .adf                  38;5;213
      .atr                  38;5;213
        # nintendo
      .gb                   38;5;213
      .gba                  38;5;213
      .gbc                  38;5;213
      .gel                  38;5;213
      .gg                   38;5;213
      .ggl                  38;5;213
      .ipk                  38;5;213 # Nintendo (DS Packed Images)
      .j64                  38;5;213
      .nds                  38;5;213
      .nes                  38;5;213
        # Sega
      .sms                  38;5;213
      # }}}
      #   Texas Instruments Calculator files {{{1
      # for more see http://tibasicdev.wikidot.com/file-extensions
      .8xp                  38;5;121
      .8eu                  38;5;121
      .82p                  38;5;121
      .83p                  38;5;121
      .8xe                  38;5;121
      # }}}
      # 3D printing {{{1
      .stl                  38;5;216
      .dwg                  38;5;216
      .ply                  38;5;216
      .wrl                  38;5;216
      # }}}
      # unsorted {{{1
      #
      #   Portable Object Translation for GNU Gettext
      .pot                  38;5;7
      #   CAD files for printed circuit boards
      .pcb                  38;5;7
      #   groff (rendering app for texinfo)
      .mm                   38;5;7
      #   GIMP files
      .gbr                  38;5;7
      .scm                  38;5;7
      .xcf                  38;5;7
      # printer spool file
      .spl                  38;5;7
      # RStudio project file
      .Rproj                38;5;11
      #   Nokia Symbian OS files
      .sis                  38;5;7

      .1p                   38;5;7
      .3p                   38;5;7
      .cnc                  38;5;7
      .def                  38;5;7
      .ex                   38;5;7
      .example              38;5;7
      .feature              38;5;7
      .ger                  38;5;7
      .ics                  38;5;7 # calendar information
      .map                  38;5;7
      .mf                   38;5;7
      .mfasl                38;5;7
      .mi                   38;5;7
      .mtx                  38;5;7
      .pc                   38;5;7
      .pi                   38;5;7
      .plt                  38;5;7
      .pm                   38;5;7
      .rdf                  38;5;7
      .ru                   38;5;7
      .sch                  38;5;7
      .sty                  38;5;7
      .sug                  38;5;7
      .tdy                  38;5;7
      .tfm                  38;5;7
      .tfnt                 38;5;7
      .tg                   38;5;7
      .vcard                38;5;7
      .vcf                  38;5;7 #contact information
      .xln                  38;5;7
      #   AppCode files
      .iml                  38;5;166
      # }}}
      # termcap {{{1
      TERM ansi
      TERM color-xterm
      TERM con132x25
      TERM con132x30
      TERM con132x43
      TERM con132x60
      TERM con80x25
      TERM con80x28
      TERM con80x30
      TERM con80x43
      TERM con80x50
      TERM con80x60
      TERM cons25
      TERM console
      TERM cygwin
      TERM dtterm
      TERM Eterm
      TERM eterm-color
      TERM gnome
      TERM gnome-256color
      TERM jfbterm
      TERM konsole
      TERM kterm
      TERM linux
      TERM linux-c
      TERM mach-color
      TERM mlterm
      TERM putty
      TERM rxvt
      TERM rxvt-256color
      TERM rxvt-cygwin
      TERM rxvt-cygwin-native
      TERM rxvt-unicode
      TERM rxvt-unicode-256color
      TERM rxvt-unicode256
      TERM screen
      TERM screen-256color
      TERM screen-256color-bce
      TERM screen-bce
      TERM screen-w
      TERM screen.linux
      TERM screen.rxvt
      TERM terminator
      TERM vt100
      TERM xterm
      TERM xterm-16color
      TERM xterm-256color
      TERM xterm-88color
      TERM xterm-color
      TERM xterm-debian
      TERM xterm-kitty
      # }}}

      # vim: ft=dircolors:fdm=marker:et:sw=2:
    '';
  };
  toFG = str: "$FG[${pkgs.lib.fixedWidthString 3 "0" str}]";
  zshtheme = pkgs.writeTextFile {
    name = "zshtheme";
    destination = "/themes/starlight.zsh-theme";
    text = ''
      git_prompt_status() {
        git_root=$PWD
        unset STATUS
        while [[ $git_root != / && ! -e $git_root/.git ]]; do
          git_root=$git_root:h
        done
        if [ ! $git_root = / ]; then
          GIT_STASHED=$(${cfg.pkgs.mygit}/bin/git stash list 2>/dev/null | wc -l)
          if [ "$GIT_UNTRACKED" -ne "0" ]; then
              STATUS="$STATUS${toFG cfg.theme.diff-remove}$ZSH_THEME_GIT_PROMPT_UNTRACKED%{$reset_color%}"
          fi
          if [ "$GIT_STAGED" -ne "0" ]; then
              STATUS="$STATUS${toFG cfg.theme.staged}$ZSH_THEME_GIT_PROMPT_STAGED%{$reset_color%}"
          fi
          if [ "$GIT_CONFLICTS" -ne "0" ]; then
              STATUS="$STATUS${toFG cfg.theme.error}$ZSH_THEME_GIT_PROMPT_CONFLICTS%{$reset_color%}"
          fi
          if [ "$GIT_CHANGED" -ne "0" ]; then
              STATUS="$STATUS${toFG cfg.theme.diff-change}$ZSH_THEME_GIT_PROMPT_CHANGED%{$reset_color%}"
          fi
          if [ "$GIT_STASHED" -ne "0" ]; then
              STATUS="$STATUS${toFG cfg.theme.localBranch}$GIT_STASHED$ZSH_THEME_GIT_PROMPT_STASHED%{$reset_color%}"
          fi
          if [ "$GIT_BEHIND" -ne "0" ]; then
              STATUS="$STATUS${toFG cfg.theme.warning}$GIT_BEHIND$ZSH_THEME_GIT_PROMPT_BEHIND%{$reset_color%}"
          fi
          if [ "$GIT_AHEAD" -ne "0" ]; then
              STATUS="$STATUS${toFG cfg.theme.diff-add}$GIT_AHEAD$ZSH_THEME_GIT_PROMPT_AHEAD%{$reset_color%}"
          fi
          if [ "$GIT_CLEAN" -eq "1" ]; then
              STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CLEAN"
          fi
          STATUS="%{$reset_color%}$ZSH_THEME_GIT_PROMPT_PREFIX"''${STATUS:+"$STATUS$ZSH_THEME_GIT_PROMPT_SEPARATOR"}
          STATUS="$STATUS${toFG cfg.theme.currentBranch}$ZSH_THEME_GIT_PROMPT_BRANCH$GIT_BRANCH%{$reset_color%}$ZSH_THEME_GIT_PROMPT_SEPARATOR"
          parent=''${git_root%\/*}
          relative=''${PWD#$parent/}
          WORKDIR="${toFG cfg.theme.path}''${relative#''${relative%\/*\/*\/*}/}%{$reset_color%}"
        else
          if [ "$PWD" = "$HOME" ]; then
            WORKDIR="${toFG cfg.theme.path}$ZSH_THEME_GIT_PROMPT_HOME%{$reset_color%}"
          else
            WORKDIR="${toFG cfg.theme.path}%3~%{$reset_color%}"
          fi
        fi
        unset git_root
        PROMPT="%(?.${toFG cfg.theme.fg-alt}.${toFG cfg.theme.error})%m$ZSH_THEME_GIT_PROMPT_PROMPT%{$reset_color%} "
        PS2="%{$reset_color%}${toFG cfg.theme.warning}%_$ZSH_THEME_GIT_PROMPT_PROMPT2%{$reset_color%} "
        RPROMPT="$STATUS$WORKDIR$ZSH_THEME_GIT_PROMPT_SUFFIX"
      }
      autoload -U add-zsh-hook
      add-zsh-hook precmd git_prompt_status
      ZSH_THEME_GIT_PROMPT_PREFIX=""
      ZSH_THEME_GIT_PROMPT_SUFFIX=""
      ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
      ZSH_THEME_GIT_PROMPT_PROMPT=""
      ZSH_THEME_GIT_PROMPT_PROMPT2=" "
      ZSH_THEME_GIT_PROMPT_BRANCH=""
      ZSH_THEME_GIT_PROMPT_STAGED=" "
      ZSH_THEME_GIT_PROMPT_CONFLICTS=" "
      ZSH_THEME_GIT_PROMPT_CHANGED=" "
      ZSH_THEME_GIT_PROMPT_UNTRACKED=" "
      ZSH_THEME_GIT_PROMPT_STASHED=""
      ZSH_THEME_GIT_PROMPT_BEHIND=""
      ZSH_THEME_GIT_PROMPT_AHEAD=""
      ZSH_THEME_GIT_PROMPT_CLEAN=""
      if [ -n "$SSH_TTY" ]; then
        ZSH_THEME_GIT_PROMPT_HOME=" "
      else
        ZSH_THEME_GIT_PROMPT_HOME=" "
      fi
    '';
  };
in
pkgs.stdenv.mkDerivation {
  name = "myzsh";
  src = ./.;
  buildInputs = with pkgs; [
    makeWrapper
    nix-zsh-completions
    oh-my-zsh
    zsh
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
    (dircolors)
    (zshtheme)
  ];
  installPhase = ''
    makeWrapper "${pkgs.zsh}/bin/zsh" "$out/bin/zsh" --set ZDOTDIR $out

    cat > $out/.zshenv <<EOF
    # Only execute this file once per shell.
    if [ -n "\$__ZDOT_ZSHENV_SOURCED" ]; then return; fi
    __ZDOT_ZSHENV_SOURCED=1
    umask 077
    if test -r "\$HOME/.zshenv"; then
      source "\$HOME/.zshenv"
    fi
    EOF

    cat > $out/.zshrc <<EOF
    # Only execute this file once per interactive shell.
    if [ -n "\$__ZDOT_ZSHRC_SOURCED" ]; then return; fi
    __ZDOT_ZSHRC_SOURCED=1
    HISTFILE="\$HOME/.zsh_history"
    export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh
    ZSH_THEME="starlight"
    ZSH_CUSTOM="${zshtheme}"
    ZLE_RPROMPT_INDENT=0
    plugins=(git colored-man-pages git-prompt)
    eval \$(${pkgs.coreutils}/bin/dircolors -b ${dircolors}/etc/dircolors)
    fpath=(${pkgs.zsh-completions}/share/zsh/site-functions ${pkgs.nix-zsh-completions}/share/zsh/site-functions \$fpath)
    # fzf with tmux
    source ${pkgs.fzf}/share/fzf/key-bindings.zsh
    source ${pkgs.fzf}/share/fzf/completion.zsh
    zstyle ':completion:*:default' list-colors \''${(s.:.)LS_COLORS} ma='48;5;${cfg.theme.bg-alt};38;5;${cfg.theme.select}'
    source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    export ZSH_HIGHLIGHT_STYLES[cursor]='fg=${cfg.theme.select}'
    export ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='fg=${cfg.theme.match}'
    export ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=${cfg.theme.error}'
    export ZSH_HIGHLIGHT_STYLES[path]='fg=${cfg.theme.path}'
    export ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=${cfg.theme.match}'
    export ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=${cfg.theme.pattern}'
    export ZSH_HIGHLIGHT_STYLES[globbing]='fg=${cfg.theme.pattern}'
    export ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=${cfg.theme.character}'
    export ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=${cfg.theme.character}'
    export ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=${cfg.theme.string}'
    export ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=${cfg.theme.function}'
    export ZSH_HIGHLIGHT_STYLES[alias]='fg=${cfg.theme.function}'
    export ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=${cfg.theme.substitution}'
    export ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=${cfg.theme.substitution}'
    export ZSH_HIGHLIGHT_STYLES[function]='fg=${cfg.theme.function}'
    export ZSH_HIGHLIGHT_STYLES[precommand]='fg=${cfg.theme.warning}'
    export ZSH_HIGHLIGHT_STYLES[command]='fg=${cfg.theme.executable}'
    export ZSH_HIGHLIGHT_STYLES[builtin]='fg=${cfg.theme.statement}'
    export ZSH_HIGHLIGHT_STYLES[redirection]='fg=${cfg.theme.keyword}'
    export ZSH_HIGHLIGHT_STYLES[arg0]='fg=${cfg.theme.keyword}'
    export ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=${cfg.theme.keyword}'
    export ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=${cfg.theme.keyword}'
    export ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=${cfg.theme.constant}'
    export ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=${cfg.theme.constant}'
    export ZSH_HIGHLIGHT_STYLES[assign]='fg=${cfg.theme.fg-alt}'
    export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=${cfg.theme.bg-alt}"
    export ZSH_AUTOSUGGEST_STRATEGY=("match_prev_cmd")
    ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=vi-forward-char
    autoload -Uz run-help
    unalias run-help
    alias help=run-help
    # spellcheck commands
    setopt correct
    # turn off completion beeps
    unsetopt LIST_BEEP
    if test -r "\$HOME/.zshrc"; then
      source "\$HOME/.zshrc"
    fi
    source \$ZSH/oh-my-zsh.sh
    # vi-like editing
    bindkey -v
    # backspace
    bindkey -a '^?' vi-backward-delete-char
    # home
    bindkey -a '\\e[1~' vi-first-non-blank
    bindkey '\\e[1~' vi-first-non-blank
    # insert
    bindkey -a '\\e[2~' vi-insert
    bindkey '\\e[2~' vi-insert # noop?
    # delete
    bindkey '\\e[3~' vi-delete-char
    bindkey -a '\\e[3~' vi-delete-char
    # end
    bindkey -a '\\e[4~'  vi-end-of-line
    bindkey '\\e[4~'  vi-end-of-line
    bindkey  "\''${terminfo[khome]}" vi-beginning-of-line
    bindkey -a "\''${terminfo[khome]}" vi-beginning-of-line
    bindkey  "\''${terminfo[kend]}" vi-end-of-line
    bindkey -a "\''${terminfo[kend]}" vi-end-of-line
    # complete word
    bindkey '^w' vi-forward-word
    bindkey '^ ' autosuggest-accept
    bindkey '^G' fzf-cd-widget
    source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    # keep zcompdump in tmp
    autoload -U compinit && compinit -d "$TMP/.$USER/zcompdump"
    # save prompt status
    zle-line-init() {
      typeset -g __prompt_status="\$?"
    }
    zle -N zle-line-init
    zle-keymap-select () {
      if [ ! "\$TERM" = "linux" ]; then
        if [ \$KEYMAP = vicmd ]; then
          echo -ne "\\e[1 q"
        else
          if [[ \$ZLE_STATE == *insert* ]]; then
            echo -ne "\\e[5 q"
          else
            echo -ne "\\e[3 q"
          fi
        fi
      fi
      () { return \$__prompt_status }
      zle reset-prompt
    }
    zle -N zle-keymap-select
    precmd() {
      if [ ! "\$TERM" = "linux" ]; then
        echo -ne "\\e[5 q"
      fi
    }
    # Load the aliases.
    . "\$ZDOTDIR/.zsh_aliases"
    if [ -f ~/.zsh_aliases ]; then
        . ~/.zsh_aliases
    fi
    EOF
    cat > $out/.zsh_aliases <<EOF
    unalias ls
    alias ls="${pkgs.coreutils}/bin/ls --color=auto"
    alias l="ls -Fh"
    alias la="l -A"
    alias ll="la -l"
    alias lt="${pkgs.tree}/bin/tree -aFC -I .git -L 2"
    alias cp="${pkgs.coreutils}/bin/cp --reflink=auto"
    alias xz="${pkgs.xz}/bin/xz --threads=0"
    alias ag="${pkgs.ag}/bin/ag --color-line-number '38;5;${cfg.theme.bg-alt}' --color-path '38;5;${cfg.theme.path}' --color-match '38;5;${cfg.theme.match}'"
    alias gdt="git difftool"
    alias gg="git all"
    alias ggc="git all gc"
    alias ggl="git all pull"
    alias ggs="git all status -sb"
    alias ggx="git all clean -fxd"
    alias gx="git clean -fxd"
    EOF

    cat > $out/.zlogin <<EOF
    if test -r ~/.zlogin; then
      . ~/.zlogin
    fi
    EOF

    cat > $out/.zlogout <<EOF
    if test -r ~/.zlogout; then
      . ~/.zlogout
    fi
    EOF
  '';
}
