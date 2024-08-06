{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment = {
    sessionVariables = {
      NAUTILUS_EXTENSION_DIR = "${config.system.path}/lib/nautilus/extensions-4";
    };

    systemPackages = with pkgs; [
      gnome-extension-manager
      nautilus-open-any-terminal
      nautilus-python
      dconf-editor
      gnome-tweaks
      gnomeExtensions.caffeine
      gnomeExtensions.no-titlebar-when-maximized
      adw-gtk3
      papirus-icon-theme
      gnome-extension-manager
      gnomeExtensions.pop-shell
    ];

    # Excluding some GNOME applications from the default install
    gnome.excludePackages =
      (with pkgs; [
        gedit # text editor
        gnome-photos
        gnome-tour
        gnome-connections
        snapshot
        cheese # webcam tool
        epiphany # web browser
        geary # email reader
        evince # document viewer
        totem # video player
        yelp # Help view
        gnome-font-viewer
      ])
      ++ (with pkgs.gnome; [
        gnome-music
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
        gnome-shell-extensions
        gnome-system-monitor
        gnome-initial-setup
        gnome-contacts
        gnome-calendar
        gnome-weather
        gnome-clocks
        gnome-maps
        # gnome-characters
      ]);
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "caps:escape";

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
}
