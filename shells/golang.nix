{
  description = "Go development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        go
        gopls
        delve
        golangci-lint
        gotools
        git
      ];

      shellHook = ''
        export GOPATH=$PWD/.go
        export GOMODCACHE=$GOPATH/pkg/mod
        export PATH=$GOPATH/bin:$PATH

        echo "Go dev environment ready"
        go version
      '';
    };
  };
}

