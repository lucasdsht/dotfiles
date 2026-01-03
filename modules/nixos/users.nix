{pkgs, ...}:

{
  # set fish as default shell
  programs.fish.enable = true;
  users.users.lucasdcht.shell = pkgs.fish;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lucasdcht = {
    isNormalUser = true;
    description = "lucas douchet";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
}
