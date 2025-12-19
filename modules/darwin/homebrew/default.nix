{ ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    casks = [
      "microsoft-edge"
      "ghostty"
      "postman"
    ];
  };
}
