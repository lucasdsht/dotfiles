{ pkgs }:

pkgs.mkShell {
  name = "node-env";

  packages = with pkgs; [
    nodejs_20
    pnpm
    yarn
    typescript
    nodePackages.typescript-language-server
  ];

  shellHook = ''
    echo "Node.js / TypeScript environment loaded"
  '';
}

