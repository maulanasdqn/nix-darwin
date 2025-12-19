{
  config,
  pkgs,
  lib,
  username,
  ...
}:
{
  imports = [
    ./system
    ./security
    ./packages
    ./defaults
    ./fonts
    ./homebrew
  ];

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };
}
