{
  description = "APOLLO - NixOS Configuration with Hyprland";

  inputs = {
    # NixOS stable channel 25.05
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    
    # Home Manager для управления пользовательскими настройками  
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Disko
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Hyprland window manager (latest)
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, disko, hyprland, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      
      # Общие аргументы для всех конфигураций
      specialArgs = { inherit inputs; };
    in
    {
      # NixOS конфигурации
      nixosConfigurations = {
        APOLLO = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            
	    # Disko module
	    disko.nixosModules.disko
	    
            # Конфигурация хоста
            ./hosts/APOLLO
            
            # Home Manager как NixOS модуль
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true; 
		backupFileExtension = "backup";
                extraSpecialArgs = specialArgs;
                users.couguar = import ./home;
              };
            }
          ];
        };
      };
      
      # Standalone Home Manager конфигурации
      homeConfigurations = {
        "couguar@APOLLO" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = specialArgs;
          modules = [ ./home ];
        };
      };
    };
}
