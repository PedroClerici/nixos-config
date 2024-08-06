{
  services.syncthing = {
    enable = true;
    user = "hotza";
    dataDir = "/home/hoza/Documents";
    configDir = "/home/hotza/.config/syncthing";
    overrideDevices = true;     # overrides any devices added or deleted through the WebUI
    overrideFolders = true;     # overrides any folders added or deleted through the WebUI
    settings = {
      devices = {
        "Redmi Note 9S" = { id = "5ENHBDN-A7MOZY4-RTN6PHH-UYFKTA6-7OP4PIN-5HM5TTA-5KCIUBR-2GQGKAA"; };
      };
      folders = {
        "Obsidian" = {         # Name of folder in Syncthing, also the folder ID
          path = "/home/hotza/Documents/Obsidian";    # Which folder to add to Syncthing
          devices = [ "Redmi Note 9S" ];      # Which devices to share the folder with
        };
        "Fitness" = {         # Name of folder in Syncthing, also the folder ID
          path = "/home/hotza/Documents/Fitness";    # Which folder to add to Syncthing
          devices = [ "Redmi Note 9S" ];      # Which devices to share the folder with
        };
      };
    };
  };
}
