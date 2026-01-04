{ ... }:

{
  imports = [
    ./boot.nix
    ./env.nix
    ./networking.nix
    ./locale.nix
    ./users.nix
    ./packages.nix
    ./desktop.nix
    ./virtualization.nix
    ./audio.nix
    ./power.nix
  ];
}

