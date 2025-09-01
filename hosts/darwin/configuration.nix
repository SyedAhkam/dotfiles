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
    neovim
    gh
    raycast
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

    # compilers / interpretors / pms
    nodejs_24
    pnpm
    bun

    # nix ecosystem
    devenv
    cachix

    # fish plugins
    fishPlugins.nvm
  ];

  # Manage homebrew declaratively
  homebrew = {
   enable = true; 
   casks = [ 
      "steam"
      "visual-studio-code@insiders"
      "whatsapp"
      "notion"
      "notion-calendar"
      "notion-mail"
      "tomatobar"
      "beekeeper-studio"
    ];
  };

  # Programs
  programs.fish.enable = true;

  # Services
  services.aerospace = {
    enable = true;
    settings = {
      mode.main.binding = {
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        alt-slash = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";

        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        alt-minus = "resize smart -50";
        alt-equal = "resize smart +50";

        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";

        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-6 = "move-node-to-workspace 6";
        alt-shift-7 = "move-node-to-workspace 7";
        alt-shift-8 = "move-node-to-workspace 8";

        alt-tab = "workspace-back-and-forth";
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";
      };
    };
  };

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
