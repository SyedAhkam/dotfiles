{ home, pkgs, ... }: 
{
  # NOTE: its not worth it to install GUI apps here because they dont get indexed by macos
  home.packages = with pkgs; [ 
  ]; 
 
  # programs.direnv.enable = true;
  # programs.direnv.nix-direnv.enable = true;

  # programs.starship.enable = true;

  # programs.fish = {
  #   enable = true;
  #   interactiveShellInit = ''
  #     starship init fish | source
  #     direnv hook fish | source
  #   '';
  # };

  home.file = {
    ".config/ghostty/config".text = ''
      shell-integration = fish
      command = fish --login --interactive
    '';
  };

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "25.05";
}
