{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    go
    gopls
    delve
    golangci-lint
    gotools
    git
  ];

  shellHook = ''
    export GOPATH="$PWD/.go"
    export GOMODCACHE="$GOPATH/pkg/mod"
    export PATH="$GOPATH/bin:$PATH"

    echo "Go dev environment ready: $(go version)"
  '';
}

