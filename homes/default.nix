{ self, impurity, inputs, ... }: {
  users.users.hotza.isNormalUser = true;

  home-manager = {
    # Tell home-manager to be as verbose as possible
    # btw i didn't found anything about it on home-manager
    # website... Does this even work?
    verbose = true;

    # Use the global pkgs that is configured via the system level.
    useGlobalPkgs = true;

    # Enable the usage user packages through
    # the users.users.<name>.packages option.
    useUserPackages = true;

    # Extra specialArgs passed to Home Manager
    # for reference, the config argument in nixos can be accessed
    # in home-manager through osConfig without us passing it.
    extraSpecialArgs = {
      inherit inputs self impurity;
    };

    # Per-user Home Manager configuration.
    users = {
      hotza = ./hotza;
    };
  };
}

