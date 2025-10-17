{ config, pkgs, ... }:
{
  imports = [
    ./plugins.nix
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    
    # Основная конфигурация
    extraLuaConfig = ''
      -- ========== ОСНОВНЫЕ НАСТРОЙКИ ==========
      vim.g.mapleader = ' '
      vim.g.maplocalleader = ' '
      
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.mouse = 'a'
      vim.opt.clipboard = 'unnamedplus'
      vim.opt.breakindent = true
      vim.opt.undofile = true
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.signcolumn = 'yes'
      vim.opt.updatetime = 250
      vim.opt.timeoutlen = 300
      vim.opt.splitright = true
      vim.opt.splitbelow = true
      vim.opt.list = true
      vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
      vim.opt.scrolloff = 10
      vim.opt.hlsearch = true
      
      -- ========== ТЕМА ==========
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
      })
      vim.cmd.colorscheme "catppuccin"
      
      -- ========== LUALINE ==========
      require('lualine').setup({
        options = {
          theme = 'catppuccin',
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
      })
      
      -- ========== NVIM-TREE ==========
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup()
      
      -- ========== TELESCOPE ==========
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
      })
      pcall(require('telescope').load_extension, 'fzf')
      
      -- ========== TREESITTER ==========
      require('nvim-treesitter.configs').setup({
        highlight = { enable = true },
        indent = { enable = true },
      })
      
      -- ========== LSP ==========
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      -- Настройка LSP серверов
      local servers = { 'nil_ls', 'pyright', 'rust_analyzer', 'tsserver' }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end
      
      -- ========== АВТОДОПОЛНЕНИЕ ==========
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
      })
      
      -- ========== ПРОЧИЕ ПЛАГИНЫ ==========
      require('Comment').setup()
      require('nvim-autopairs').setup()
      require('gitsigns').setup()
      require('which-key').setup()
      require('bufferline').setup()
      
      -- ========== КЛАВИАТУРНЫЕ СОКРАЩЕНИЯ ==========
      local keymap = vim.keymap.set
      
      -- Общие
      keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')
      keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
      
      -- Telescope
      keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = '[F]ind [F]iles' })
      keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = '[F]ind by [G]rep' })
      keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = '[F]ind [B]uffers' })
      
      -- Nvim-tree
      keymap('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle [E]xplorer' })
      
      -- Буферы
      keymap('n', '<leader>bn', '<cmd>bnext<cr>', { desc = '[B]uffer [N]ext' })
      keymap('n', '<leader>bp', '<cmd>bprevious<cr>', { desc = '[B]uffer [P]revious' })
      keymap('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = '[B]uffer [D]elete' })
    '';
  };
  
  # LSP серверы и инструменты
  home.packages = with pkgs; [
    # Nix
    nil
    nixfmt-rfc-style
    
    # Python
    pyright
    black
    
    # Rust
    rust-analyzer
    
    # JavaScript/TypeScript
    nodePackages.typescript-language-server
    nodePackages.prettier
    
    # Другие полезные инструменты
    ripgrep
    fd
  ];
}