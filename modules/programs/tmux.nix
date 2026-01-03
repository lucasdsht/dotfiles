{pkgs, ...}:

{
  programs.tmux = {
    enable = true;
    prefix = "C-t";
    keyMode = "vi";
    baseIndex = 1;
    clock24 = true;

    plugins = with pkgs; [
      tmuxPlugins.catppuccin
    ];
    
    extraConfig = ''
      # UTF-8 and truecolor
      set -g utf8 on
      set -g status-utf8 on
      set -g terminal-overrides ',xterm-256color:Tc'

      # Let Starship render Unicode icons
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",*:Tc"
    '';
  };
}
