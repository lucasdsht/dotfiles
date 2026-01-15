{ pkgs }:

pkgs.mkShell {
  name = "csharp-env";

  packages = with pkgs; [
    dotnet-sdk_8
    omnisharp-roslyn
  ];

  shellHook = ''
    export DOTNET_CLI_TELEMETRY_OPTOUT=1
    export DOTNET_NOLOGO=1
    echo "C# / .NET environment loaded"
  '';
}

