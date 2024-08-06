{ self, ... }:
let
  inherit (self) inputs;
  inherit (inputs) nixpkgs home-manager;

  # Set the entry point for home-manager configurations
  homeDir = self + /homes;

  # If a host uses home-manager, then it can simply import this list
  homes = [
    homeDir
    home-manager.nixosModules.home-manager
  ];

  impurity = inputs.impurity;
in
{
  "thinkpad" = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules =
      [
        {
          # Impurity
          imports = [ impurity.nixosModules.impurity ];
          impurity.configRoot = self;
          impurity.enable = true;
        }

        ./thinkpad # This imports your entire host configuration in one swoop

        # This part is basically the same as putting configuration in your
        # configuration.nix, but is done on the topmost level for your convenience
        {
          networking.hostName = "thinkpad";
          _module.args = { username = "hotza"; };
        }
      ]
      ++ homes; # Imports the home-manager related configurations
  };

  # Impurity setup
  "thinkpad-impure" = self.nixosConfigurations."thinkpad".extendModules { modules = [{ impurity.enable = true; }]; };
}
