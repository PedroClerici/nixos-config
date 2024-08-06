let
  username = "hotza";
  homeDirectory = "/home/hotza";
in
{
  imports = [
    # Desktop
    ./alacritty.nix
    ./gnome.nix
    ./obsidian.nix
    ./vesktop.nix

    # Development
    ./devbox.nix

    # Shell
    ./fastfetch.nix
    ./oh-my-posh.nix
    ./tmux.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  home = {
    inherit username homeDirectory;
    sessionVariables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXPKGS_ALLOW_INSECURE = "1";
    };
    sessionPath = [
      "$HOME/.local/bin"
    ];
  };
  
  programs.git = {
    enable = true;
    userName  = "Pedro Clerici";
    userEmail = "pedro.clerici@protonmail.com";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  home.stateVersion = "24.11";
}
