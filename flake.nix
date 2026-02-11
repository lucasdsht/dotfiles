{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf.url = "github:notashelf/nvf";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # stylix.url = "github:danth/stylix";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nvf, firefox-addons, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    # ===== Dev shells (nix develop) =====
    devShells.${system} = {
      csharp = import ./shells/csharp.nix { inherit pkgs; };
      node   = import ./shells/node.nix   { inherit pkgs; };
      python = import ./shells/python.nix { inherit pkgs; };
      go     = import ./shells/golang.nix { inherit pkgs; };
    };

 
    nixosConfigurations.hostname = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {inherit inputs self;};
      modules = [
        # stylix.nixosModules.stylix
        ./hosts/default/configuration.nix
        
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = {inherit inputs;};

          # Import nvf HM module here
          home-manager.users.lucasdcht = {
            imports = [
              nvf.homeManagerModules.default
              ./hosts/default/home.nix
            ];
          };
        }
      ];
    };
  };
}

