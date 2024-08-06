{ pkgs, ... }:
{
  console = {
    earlySetup = true;
    packages = with pkgs; [
      terminus_font
    ];
    font = "ter-132n";
  };
}
