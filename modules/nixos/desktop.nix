{...}:

{
  
  programs.niri.enable = true;
  programs.hyprland.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.displayManager.sddm= {
    enable = true;
    wayland.enable = true;
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;
}
