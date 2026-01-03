# modules/nixos/env.nix
{ config, pkgs, ... }:

let
  cursor = config.stylix.cursor or {};
in
{
  environment.sessionVariables = {
    XCURSOR_THEME = "catppuccin-mocha-pink";
  };
}

