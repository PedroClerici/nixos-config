{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # A system for managing user environments.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Allows syslinking dotfiles.
    impurity.url = "github:outfoxxed/impurity.nix";

    # A helper for basic nix commands, adding
    # functionality and pretty outputs!
    nh.url = "github:viperML/nh";
  };

  outputs = { self, ... }: {
    # Editing flake.nix triggers certain utilities such as direnv
    # to reload, editing host configurations do not require a direnv
    # reload, so lets move hosts out of the way.
    nixosConfigurations = import ./hosts { inherit self; };
  };
}
