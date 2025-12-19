{
  config,
  pkgs,
  lib,
  username,
  nixvim,
  ...
}:
{
  imports = [
    ./options.nix
    ./keymaps.nix
    ./plugins
  ];

  home-manager.users.${username} = {
    imports = [
      nixvim.homeModules.nixvim
    ];

    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      version.enableNixpkgsReleaseCheck = false;

      extraPackages = with pkgs; [
        ripgrep
        fd
        prettierd
        stylua
        nixfmt-rfc-style
        eslint_d
      ];
    };
  };
}
