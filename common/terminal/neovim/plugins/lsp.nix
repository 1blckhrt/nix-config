_: {
  programs.nixvim = {
    plugins = {
      lsp-signature.enable = true;
      lspkind.enable = true;
      lspsaga.enable = true;
      friendly-snippets.enable = true;
      lazydev.enable = true;
    };
    lsp = {
      servers = {
        bashls.enable = true;
        cssls.enable = true;
        eslint.enable = true;
        html.enable = true;
        jsonls.enable = true;
        nil_ls.enable = true;
        markdown_oxide.enable = true;
        lua_ls.enable = true;
        rust_analyzer.enable = true;
        sqruff.enable = true;
        stylua.enable = true;
        ty.enable = true;
        "*".config.root_markers = [
          ".git"
        ];
      };
    };
  };
}
