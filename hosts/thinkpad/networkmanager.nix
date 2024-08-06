{
  networking = {
    networkmanager = {
      enable = true;
      # Why?
      # wifi = {
      #   backend = "iwd";
      # };
    };
  };

  # Workaround https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;
}
