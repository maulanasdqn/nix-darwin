{ username, sops-nix, pkgs, secretsFile, ... }:
{
  home-manager.users.${username} = { config, ... }: {
    imports = [
      sops-nix.homeManagerModules.sops
    ];

    # Add sops and age to packages for managing secrets
    home.packages = with pkgs; [
      sops
      age
    ];

    sops = {
      # Age key location
      age.keyFile = "/Users/${username}/.config/sops/age/keys.txt";

      # Default secrets file (passed from flake)
      defaultSopsFile = secretsFile;

      # Define secrets to decrypt
      secrets = {
        github_token = { };
        openai_api_key = { };
        anthropic_api_key = { };
        database_password = { };
      };
    };
  };
}
