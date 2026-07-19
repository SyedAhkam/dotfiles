# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Allow Unfree
  nixpkgs.config.allowUnfree = true;

  # Allow experimental commands
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Nvidia
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia.open = true;

  # Hostname
  networking.hostName = "syed-nix";

  # Greetd
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''${pkgs.greetd}/bin/agreety --cmd "bash -l -c "start-hyprland""'';
        user = "greeter";
      };
    };
  };

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_ML = "1"; # helps window clients

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Trusted users
  nix.settings.trusted-users = [ "root" "syed" ];

  # Define a user account.
  users.users.syed = {
   isNormalUser = true;
   extraGroups = [ "wheel" "networkmanager" ];
   packages = with pkgs; []; # I let home manager handle user packages
  };

  # Programs
  programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  # Disable firewall
  networking.firewall.enable = false;

  # Home manager
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };

    users = {
      "syed" = import ./home.nix;
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
