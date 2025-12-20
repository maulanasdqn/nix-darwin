{ ... }:
{
  system.defaults.NSGlobalDomain = {
    AppleShowAllExtensions = true;
    ApplePressAndHoldEnabled = false;
    KeyRepeat = 2;
    InitialKeyRepeat = 15;
    NSAutomaticWindowAnimationsEnabled = false;
    NSWindowResizeTime = 0.001;
  };

  # Disable Spotlight shortcut (Cmd+Space) so Raycast can use it
  system.defaults.CustomUserPreferences = {
    "com.apple.symbolichotkeys" = {
      AppleSymbolicHotKeys = {
        # Disable Spotlight (64 = Cmd+Space)
        "64" = { enabled = false; };
        # Disable Finder search (65)
        "65" = { enabled = false; };
      };
    };
  };
}
