{ username, ... }:
{
  home-manager.users.${username}.programs.zsh.shellAliases = {
    # General
    c = "clear";
    v = "nvim";
    t = "tmux";
    cl = "claude";

    # Eza (better ls)
    ls = "eza";
    ll = "eza -la";
    la = "eza -a";
    lt = "eza --tree";
    l = "eza -l";

    # Bat (better cat)
    cat = "bat";
  };
}
