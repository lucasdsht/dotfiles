{ pkgs, ... }:

let
  aliasSet = {
    ll = "eza -l --icons";
    lla = "ll -a";
    tree = "eza --icons --tree";
    vim = "nvim";
    cat = "bat";
    ff = "fastfetch";
    lg = "lazygit";
    v = "nvim";
    t = "tmux";
    z = "zoxide";
    nrs = "sudo nixos-rebuild switch --flake ~/nixos#hostname";
  };

in {
  programs.fish = {
    enable = true;
    shellAliases = aliasSet;
    shellInit = ''
      function fish_greeting; end;
      direnv hook fish | source
    '';
    plugins = [
      {
        name = "plugin-git";
        src = pkgs.fishPlugins.plugin-git.src;
      }
    ];
  };
}
