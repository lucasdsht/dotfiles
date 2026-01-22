{ pkgs }:

pkgs.mkShell {
  name = "csharp-env";

  packages = with pkgs; [
    dotnet-sdk_9
    omnisharp-roslyn
  ];

  shellHook = ''
    export DOTNET_CLI_TELEMETRY_OPTOUT=1
    export DOTNET_NOLOGO=1

    export DOTNET_ROOT="${pkgs.dotnet-sdk_9}/share/dotnet"
    export PATH="$DOTNET_ROOT:$PATH"

    echo "C# / .NET environment loaded"
    dotnet --info | head -n 5
  '';
}

