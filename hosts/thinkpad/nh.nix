{ pkgs, ... }:
{
  programs.nh = {
    enable = true;
    package = pkgs.nh;
    flake = "/home/hotza/.config/nixos/";
    clean = {
      enable = true;
      extraArgs = "--keep-since 10d --keep 3";
    };
  };

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}

