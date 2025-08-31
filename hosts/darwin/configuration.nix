{ self, lib, specialArgs, config, inputs, pkgs, ... }: { 
  imports = [  ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # Primary user
  system.primaryUser = "syed";

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # NS Global Settings
  system.defaults.NSGlobalDomain = {
    KeyRepeat = 1;
    InitialKeyRepeat = 10;
    ApplePressAndHoldEnabled = false; # disables accent popup
    NSAutomaticCapitalizationEnabled = false; # Disable auto-capitalization
    AppleShowAllExtensions = true;     # Always show file extensions
    NSWindowShouldDragOnGesture = true; # enable moving window by holding anywhere on it like on Linux
  };

  # Configure the Dock
  system.defaults.dock = {
    enable-spring-load-actions-on-all-items = true;
    expose-group-apps = true;
    magnification = true;
    largesize = 64;
    tilesize = 32;
    minimize-to-application = true;
    orientation = "left";
    showhidden = true;
    autohide = true;
  };

  # Battery percentage
  system.defaults.controlcenter.BatteryShowPercentage = true;

  # Hot corners
  system.defaults.dock.wvous-bl-corner = 2; # Mission control
  system.defaults.dock.wvous-br-corner = 14; # Quick note
  system.defaults.dock.wvous-tl-corner = 11; # Launchpad
  system.defaults.dock.wvous-tr-corner = 4; # Show desktop

  # Fix finder
  system.defaults.finder = {
    FXDefaultSearchScope = "SCcf"; # Search scope limited to current folder
    FXEnableExtensionChangeWarning = false; # No warning when changing file extensions
    FXRemoveOldTrashItems = true; # Clear trash every 30d
    NewWindowTarget = "Home"; # New windows should open on ~
    QuitMenuItem = true; # Allow finder to be quit
    ShowPathbar = true; # Shows path
    _FXShowPosixPathInTitle = true; # Show full path
    ShowStatusBar = true; # Shows some stats
  };

  # Packages installed system wide
  environment.systemPackages = with pkgs; [ 
    ghostty-bin
    brave
    discord
    # cloudflare-warp not on mac
    # kde-connect
    slack
    shottr
    telegram-desktop
    # beekeeper
    chatgpt
    gimp
    monitorcontrol
    # obsidian not on mac???
    spotify
    warp-terminal
    # whatsapp-for-mac build failure
    zed-editor
    # zen browser not in nixpkgs??
  ];

  # Manage homebrew declaratively
  homebrew = {
   enable = true; 
   casks = [ "steam" "visual-studio-code@insiders"];
  };

  # Programs
  programs.fish.enable = true;

  # User
  users.users.syed = {
    name = "syed";
    home = "/Users/syed";
  };

  # Home manager
  home-manager = { 
   useGlobalPkgs = true;
   useUserPackages = true;

   extraSpecialArgs = { inherit inputs; };
   users.syed = import ./home.nix;
  };
}
