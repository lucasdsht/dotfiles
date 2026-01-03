{ ... }:
{
  programs.starship = {
    enable = true;

    # active l'intégration dans fish (et autres si besoin)
    enableFishIntegration = true;

    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };
}

