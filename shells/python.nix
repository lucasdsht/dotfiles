{ pkgs }:
pkgs.mkShell {
  name = "python-env";
  packages = with pkgs; [
    python312
    python312Packages.pip
    python312Packages.virtualenv
    python312Packages.ipython
    python312Packages.black
    python312Packages.pytest
  ];
  shellHook = ''
    echo "Python environment loaded"
  '';
}

