{ pkgs }:

let
  mingw = pkgs.pkgsCross.mingwW64;
in

pkgs.mkShell {
  packages = with pkgs; [
    go
    gopls
    delve
    golangci-lint
    gotools
    git

    # Windows cross compiler (required for CGO + DLL)
    mingw.stdenv.cc
  ];

  shellHook = ''
    # Local Go workspace
    export GOPATH="$PWD/.go"
    export GOMODCACHE="$GOPATH/pkg/mod"
    export PATH="$GOPATH/bin:$PATH"

    # Windows cross-compilation settings
    export GOOS=windows
    export GOARCH=amd64
    export CGO_ENABLED=1

    export CC=x86_64-w64-mingw32-gcc
    export CXX=x86_64-w64-mingw32-g++
    export AR=x86_64-w64-mingw32-ar
    export RANLIB=x86_64-w64-mingw32-ranlib

    echo "Go dev environment ready: $(go version)"
    echo "Windows cross compiler: $($CC --version | head -n1)"
  '';
}

