{ ... }:

{
  security.sudo.extraRules = [
    {
      users = [ "lucasdcht" ];
      commands = [
        {
          command = "/nix/var/nix/profiles/system/specialisation/*/bin/switch-to-configuration";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}

