{ config, lib, pkgs, ... }:
{
  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "caffeine@patapon.info"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "no-titlebar-when-maximized@alec.ninja"
        "pop-shell@system76.com"
      ];

      # favorite-apps = ["files.desktop" "brave.desktop" "alacritty.desktop"];
      had-bluetooth-devices-setup = true;
      remember-mount-password = false;
      welcome-dialog-last-shown-version = "42.4";
    };

    "org/gnome/desktop/input-sources" = {
      xkb-options=["caps:escape_shifted_capslock" "ctrl:ralt_rctrl"];
    };

    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      switch-to-application-5 = [];
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };

    "org/gnome/desktop/interface" = {
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      gtk-theme = "adw-gtk3-dark";
      icon-theme="Papirus";
      toolkit-accessibility = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>q"];
      minimize = ["<Super>comma"];
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      move-to-workspace-1 = ["<Shift><Super>1"];
      move-to-workspace-2 = ["<Shift><Super>2"];
      move-to-workspace-3 = ["<Shift><Super>3"];
      move-to-workspace-4 = ["<Shift><Super>4"];
      move-to-workspace-5 = ["<Shift><Super>5"];
      switch-to-workspace-left = ["<Super>bracketleft"];
      switch-to-workspace-right = ["<Super>bracketright"];
      toggle-maximized = ["<Super>Up"];
    };

    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 5;
    };

    "org/gnome/desktop/notifications" = {
      show-in-lock-screen = false;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "terminal super";
      command = "alacritty";
      binding = "<Super>Return";
    };
  };

  # Fixes issue bellow
  # https://www.reddit.com/r/NixOS/comments/1dsamfh/apps_via_home_manager_are_not_visible_within_gnome/
  programs.bash.profileExtra = lib.mkAfter ''
    rm -rf ${config.home.homeDirectory}/.local/share/applications/home-manager
    rm -rf ${config.home.homeDirectory}/.icons/nix-icons
    ls ${config.home.homeDirectory}/.nix-profile/share/applications/*.desktop > ${config.home.homeDirectory}/.cache/current_desktop_files.txt
  '';
  home.activation = {
    linkDesktopApplications = {
      after = ["writeBoundary" "createXdgUserDirectories"];
      before = [];
      data = ''
        rm -rf ${config.home.homeDirectory}/.local/share/applications/home-manager
        rm -rf ${config.home.homeDirectory}/.icons/nix-icons
        mkdir -p ${config.home.homeDirectory}/.local/share/applications/home-manager
        mkdir -p ${config.home.homeDirectory}/.icons
        ln -sf ${config.home.homeDirectory}/.nix-profile/share/icons ${config.home.homeDirectory}/.icons/nix-icons

        # Check if the cached desktop files list exists
        if [ -f ${config.home.homeDirectory}/.cache/current_desktop_files.txt ]; then
          current_files=$(cat ${config.home.homeDirectory}/.cache/current_desktop_files.txt)
        else
          current_files=""
        fi

        # Symlink new desktop entries
        for desktop_file in ${config.home.homeDirectory}/.nix-profile/share/applications/*.desktop; do
          if ! echo "$current_files" | grep -q "$(basename $desktop_file)"; then
            ln -sf "$desktop_file" ${config.home.homeDirectory}/.local/share/applications/home-manager/$(basename $desktop_file)
          fi
        done

        # Update desktop database
        ${pkgs.desktop-file-utils}/bin/update-desktop-database ${config.home.homeDirectory}/.local/share/applications
      '';
    };
  };
}
