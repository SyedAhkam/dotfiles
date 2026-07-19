{ config, pkgs, ... }:

{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "syed";
  home.homeDirectory = "/home/syed";

  # Packages
  home.packages = with pkgs; [
    tree
    kitty
    pavucontrol
    gh
    hyprlauncher
    zed-editor
  ];

  # Files
  home.file = {};

  # Out of store symlinks
  xdg.configFile."hypr/hyprland.lua".source = config.lib.file.mkOutOfStoreSymlink "/home/syed/dotfiles/hyprland/hyprland.lua";
  xdg.configFile."hypr/system.lua".source = config.lib.file.mkOutOfStoreSymlink "/home/syed/dotfiles/hyprland/system.lua";
  xdg.configFile."hypr/keybinds.lua".source = config.lib.file.mkOutOfStoreSymlink "/home/syed/dotfiles/hyprland/keybinds.lua";
  xdg.configFile."hypr/animations.lua".source = config.lib.file.mkOutOfStoreSymlink "/home/syed/dotfiles/hyprland/animations.lua";

  # Environment variables
  home.sessionVariables = {};

  # Programs
  programs.git = {
    enable = true;
    userName = "sedbytes";
    userEmail = "smahkam57@gmail.com";
  };

  # Let Home Manger install and manage itself.
  programs.home-manager.enable = true;
}
