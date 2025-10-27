{
  description = "Home Manager configuration of esauvage";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixgl,
    ...
  }: let
    system = "x86_64-linux";
    username = "esauvage";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        ./home.nix
        {
          home = {
            inherit username;
            homeDirectory = "/home/${username}";
            stateVersion = "22.05";
          };
          nix = {
            package = pkgs.nix;
            settings.experimental-features = [
              "nix-command"
              "flakes"
            ];
          };
          nixpkgs.config.allowUnfree = true;
        }
      ];

      extraSpecialArgs = {inherit nixgl;};
    };
  };
}
