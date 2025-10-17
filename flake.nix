{
  description = "APOLLO - NixOS Configuration with Hyprland";

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
  };

  outputs = { self, nixpkgs, home-manager, disko, hyprland, ... } @ inputs:
    let
      system = "x86_64-linux";
      
      # Функция для создания хост-конфигурации
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
      # NixOS конфигурации
      nixosConfigurations = {
        # Основной ноутбук
        APOLLO = mkHost "APOLLO" "couguar" [];
        
        # Пример второго хоста (раскомментируйте когда понадобится)
        # DESKTOP = mkHost "DESKTOP" "couguar" [];
      };
      
      # Standalone Home Manager конфигурации (для не-NixOS систем)
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