{
  description = "ms's nix-darwin configuration";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";

    nix-darwin = {
      url = "https://flakehub.com/f/nix-darwin/nix-darwin/0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "https://flakehub.com/f/nix-community/home-manager/0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      determinate,
      nixvim,
      ...
    }:
    let
      username = "ms";
      system = "aarch64-darwin";
      hostname = "mrscraper";

      specialArgs = {
        inherit username nixvim;
      };
    in
    {
      darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
        inherit system specialArgs;
        modules = [
          # Determinate Nix
          determinate.darwinModules.default

          # Home Manager
          home-manager.darwinModules.home-manager

          # Custom modules
          ./modules/nix.nix
          ./modules/darwin
          ./modules/home
        ];
      };

      # Development shell
      devShells.${system}.default =
        let
          pkgs = import nixpkgs { inherit system; };
        in
        pkgs.mkShellNoCC {
          packages = with pkgs; [
            (writeShellApplication {
              name = "rebuild";
              runtimeInputs = [ nix-darwin.packages.${system}.darwin-rebuild ];
              text = ''
                echo "Rebuilding nix-darwin configuration..."
                sudo darwin-rebuild switch --flake .
                echo "Done!"
              '';
            })
            self.formatter.${system}
          ];
        };

      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
    };
}
