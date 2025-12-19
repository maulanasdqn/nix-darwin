{
  config,
  pkgs,
  lib,
  username,
  ...
}:
{
  imports = [
    ./zsh
    ./neovim
    ./tmux
  ];

  nixpkgs.config.allowUnfree = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";

  home-manager.users.${username} = {
    home.stateVersion = "24.11";
    home.packages = with pkgs; [
      ripgrep
      fd
      fzf
      eza
      bat
      jq
      tree
      volta
      bun
      deno
      rustup
      slack
    ];

    home.sessionVariables = {
      VOLTA_HOME = "$HOME/.volta";
      RUSTUP_HOME = "$HOME/.rustup";
      CARGO_HOME = "$HOME/.cargo";
    };

    home.sessionPath = [
      "$HOME/.volta/bin"
      "$HOME/.cargo/bin"
      "$HOME/.bun/bin"
      "$HOME/.deno/bin"
    ];

    programs.git = {
      enable = true;
      settings = {
        user.name = "maulanasdqn";
        user.email = "maulanasdqn@gmail.com";
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
      };
    };

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
