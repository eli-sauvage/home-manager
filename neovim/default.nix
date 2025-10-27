{
  pkgs,
  lib,
  config,
  ...
}: {
  xdg.configFile.nvim = {
    source = ./lua;
    target = "nvim/lua";
    recursive = true;
  };
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = ''
      colorscheme codedark
    '';
    extraLuaConfig = ''
      ${builtins.readFile ./init.lua}
    '';
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      nvim-treesitter-parsers.vue
      nvim-treesitter-parsers.hcl
      #colorscheme
      vim-code-dark
      nvim-solarized-lua
      #icons
      nvim-web-devicons

      #tabs
      barbar-nvim
      #status line
      #works best for me, at least, for now
      #TODO:maybe switch to something else
      lightline-vim
      #git stuff
      vim-signify
      telescope-nvim
      telescope-fzy-native-nvim
      undotree
      #keymap hints
      which-key-nvim
      #file tree
      neo-tree-nvim

      #automatic comments, but in lua
      kommentary
      #automatic surrounds, but in lua
      nvim-surround
      #autoclose parentheses, quotes, brackets, etc
      vim-closer

      ##intellisense
      #completion engine
      nvim-cmp
      #common completion sources
      cmp-buffer
      cmp-path
      cmp-zsh
      cmp-nvim-lua
      cmp-nvim-lsp-signature-help
      #snippet engine, collection and completion source
      luasnip
      friendly-snippets
      cmp_luasnip
      #native lsp config engine, completion source
      nvim-lspconfig
      lspsaga-nvim
      cmp-nvim-lsp
      #formatting, linting and diagnostics
      none-ls-nvim

      lazygit-nvim

      rustaceanvim
      nvim-dap
    ];
  };

  home.packages = with pkgs; [
    # deno
    asm-lsp
    typescript
    typescript-language-server
    pyright
    black
    xclip
    ripgrep
    editorconfig-checker
    nodePackages.prettier
    statix
    deadnix
    alejandra
    nil
    ansible-lint
    yamllint
    lua53Packages.luacheck
    stylua
    checkmake
    lldb
  ];
}
