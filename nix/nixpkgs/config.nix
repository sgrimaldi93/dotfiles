with import <nixpkgs> {};

rec {
  allowUnfree = true;


  packageOverrides = pkgs: with pkgs; rec {

    speedtest-cli-api = pythonPackages.buildPythonPackage rec {
      inherit (speedtest-cli) name version meta src;
    };

    i3pystatus = pkgs.i3pystatus.overrideAttrs (oldAttrs: {
      extraLibs = with python3Packages; [ pygeoip ];
    });

    # My basic packages.
    base = pkgs.buildEnv {
      name = "base-packages";
      paths = [
        diceware
        i3pystatus
        man
        perl
        pypi2nix
        texinfoInteractive
        zsh
      ];

      pathsToLink = [
        "/bin"
        "/etc"
        "/share/doc"
        "/share/info"
        "/share/man"
      ];

      extraOutputsToInstall = [
        "doc"
        "info"
        "man"
      ];
      postBuild = ''
        if [ -x $out/bin/install-info -a -w $out/share/info ]; then
          shopt -s nullglob
          for i in $out/share/info/*.info $out/share/info/*.info.gz; do
              $out/bin/install-info $i $out/share/info/dir
          done
        fi
      '';
    };
  };
}
