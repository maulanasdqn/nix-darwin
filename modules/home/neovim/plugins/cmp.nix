{ username, ... }:
{
  home-manager.users.${username}.programs.nixvim.plugins = {
    cmp = {
      enable = true;
      settings = {
        completion.completeopt = "menu,menuone,preview,noselect";
        snippet.expand = ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end
        '';
        mapping = {
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<C-j>" = "cmp.mapping.select_next_item()";
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = false })";
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
        window = {
          completion.__raw = "cmp.config.window.bordered()";
          documentation.__raw = "cmp.config.window.bordered()";
        };
      };
    };

    cmp-nvim-lsp.enable = true;
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp_luasnip.enable = true;

    luasnip = {
      enable = true;
      fromVscode = [{}];
    };

    lspkind = {
      enable = true;
      cmp.enable = true;
      settings.cmp.menu = {
        nvim_lsp = "[LSP]";
        luasnip = "[Snip]";
        buffer = "[Buf]";
        path = "[Path]";
      };
    };
  };
}
