{ pkgs, ... }:
{
  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./console.nix
    ./gnome.nix
    ./hardware.nix
    ./locale.nix
    ./networkmanager.nix
    ./nh.nix
    ./syncthing.nix
  ];

  nixpkgs.config.allowUnfree = true;

  environment.defaultPackages = with pkgs; [
    bat
    curl
    wget
    file
    git
    killall
    nfs-utils
    ntfs3g
    ripgrep
    tree
    eza
    unzip
    neovim
    gcc
    cargo
    btop
    brave
  ];

  programs.nix-ld.enable = true;

  system.stateVersion = "23.11";
}
