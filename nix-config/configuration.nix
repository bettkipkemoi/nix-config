_:
 
{
  services.nix-daemon.enable = true;
 
  users.users.bettrere = {
    home = "/Users/bettrere";
  };
 
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
    extra-platforms =  aarch64-darwin
  '';
 
  homebrew = {
    enable = true;
 
    casks = [
      "discord"
      "visual-studio-code"
    ];
  };
}
