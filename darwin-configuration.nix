{ config, pkgs, ... }:

{
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Essential tools
    vim
    git
    curl
    wget
    tree
    htop
    
    # Development tools
    jq
    ripgrep
    fd
    bat
    
    # Modern CLI tools
    eza
    fzf
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  
  # Nix configuration
  nix.settings = {
    experimental-features = "nix-command flakes";
    # Automatically optimize the nix store
    auto-optimise-store = true;
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";

  # macOS system defaults
  system.defaults = {
    # Dock settings
    dock = {
      autohide = true;
      orientation = "bottom";
      show-recents = false;
      tilesize = 48;  # Size of dock icons in pixels (default: 64)
      minimize-to-application = true;
      launchanim = false;
    };

    # Finder settings
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = false;
      ShowPathbar = true;
      ShowStatusBar = true;
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "Nlsv"; # List view
      _FXShowPosixPathInTitle = true;
    };

    # NSGlobalDomain settings (general system preferences)
    NSGlobalDomain = {
      # Expand save panel by default
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      
      # Expand print panel by default
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;
      
      # Save to disk (not to iCloud) by default
      NSDocumentSaveNewDocumentsToCloud = false;
      
      # Enable full keyboard access for all controls
      AppleKeyboardUIMode = 3;
      
      # Set fast key repeat rate
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      
      # Disable auto-correct
      NSAutomaticSpellingCorrectionEnabled = false;
      
      # Enable tap to click
      "com.apple.mouse.tapBehavior" = 1;
      
      # Show all file extensions
      AppleShowAllExtensions = true;
    };

    # Trackpad settings
    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };

    # Custom settings not covered by nix-darwin
    CustomUserPreferences = {
      # Prevent Photos from opening automatically when devices are plugged in
      "com.apple.ImageCapture" = {
        disableHotPlug = true;
      };
    };
  };

  # Keyboard settings
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
}
