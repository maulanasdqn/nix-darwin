{ username, ... }:
{
  home-manager.users.${username}.programs.nixvim.plugins = {
    lsp = {
      enable = true;
      servers = {
        lua_ls = {
          enable = true;
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false;
              };
              telemetry.enable = false;
            };
          };
        };
        nil_ls.enable = true;
        ts_ls.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        taplo.enable = true;
        tailwindcss.enable = true;
        emmet_ls.enable = true;
        html.enable = true;
        cssls.enable = true;
      };
      keymaps = {
        lspBuf = {
          "gd" = "definition";
          "K" = "hover";
        };
      };
    };

    lspsaga = {
      enable = true;
      settings = {
        lightbulb.enable = false;
      };
    };
  };
}
