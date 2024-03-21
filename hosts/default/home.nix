{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "syed";
  home.homeDirectory = "/home/syed";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Workaround to allow unfree packages using home-manager
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.hello

    pkgs.gh # github-cli
    pkgs.obsidian
    pkgs.vivaldi
    pkgs.spotify
    pkgs.syncthingtray

    pkgs.rustup

    # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    (pkgs.writeShellScriptBin "prime-run" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec "$@"
    '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/syed/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = { EDITOR = "vim"; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # ----------------------------- Programs ----------------------------------

  programs.git = {
    enable = true;
    userName = "Syed Ahkam";
    userEmail = "smahkam57@gmail.com";
  };

  programs.starship.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = "starship init fish | source";
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  # -------------------------- Desktop Files -----------------------------

  xdg.desktopEntries.doom-emacs = {
    name = "Doom Emacs";
    exec = "SHELL=fish DOOMDIR=/home/syed/dotfiles/doom emacs %F";
    icon = "emacs";
    comment = "Edit text";
  };

  # ------------------------- Services -----------------------------------
  services.syncthing = {
    enable = true;
    tray.enable = true;
    extraOptions = [ "--no-default-folder" ];
  };
}
