{
  description = "APOLLO - NixOS Configuration with Hyprland & AGS v1";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # AGS v1 (stable)
    ags = {
      url = "github:aylur/ags/v1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, disko, hyprland, ags, ... } @ inputs:
    let
      system = "x86_64-linux";

      # Helper function to create NixOS configurations
      mkHost = hostname: username: modules: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs hostname username; };
        modules = [
          disko.nixosModules.disko
          ./hosts/${hostname}

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit inputs hostname username; };
              users.${username} = import ./home/${username};
            };
          }
        ] ++ modules;
      };
    in
    {
      # NixOS configurations
      nixosConfigurations = {
        APOLLO = mkHost "APOLLO" "couguar" [];
      };

      # Standalone home-manager configurations
      homeConfigurations = {
        "couguar@APOLLO" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = {
            inherit inputs;
            hostname = "APOLLO";
            username = "couguar";
          };
          modules = [ ./home/couguar ];
        };
      };
    };
}
