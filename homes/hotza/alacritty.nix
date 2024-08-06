{
  programs.alacritty = {
    enable = true;

    settings = {
      env = {
        TERM = "alacritty";
      };

      window = {
        padding = {
          x = 10;
          y = 10;
        };
      };

      live_config_reload = true;
      scrolling.history = 100000;

      font = {
        normal.family = "JetBrainsMono Nerd Font";
        size = 18;
      };

      colors = {
        # Default colors
        primary = {
          background =  "#000000";
          foreground =  "#eeeeee";
        };

        # Normal colors
        normal = {
          black   = "#000000";
          red     = "#ee6d85";
          green   = "#98c379";
          yellow  = "#dfae67";
          blue    = "#7199ee";
          magenta = "#a485dd";
          cyan    = "#38a89d";
          white   = "#eeeeee";
        };

        # Bright colors
        bright = {
          black   = "#4d4d4d";
          red     = "#f7768e";
          green   = "#9ece6a";
          yellow  = "#e0af68";
          blue    = "#7aa2f7";
          magenta = "#bb9af7";
          cyan    = "#7dcfff";
          white   = "#ffffff";
        };
      };
    };
  };
}
