{ config, pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    # ========== UI и ТЕМЫ ==========
    catppuccin-nvim           # Тема Catppuccin
    nvim-web-devicons         # Иконки для файлов
    lualine-nvim              # Статус линия внизу
    bufferline-nvim           # Табы для буферов
    indent-blankline-nvim     # Линии отступов
    
    # ========== НАВИГАЦИЯ И ПОИСК ==========
    telescope-nvim            # Fuzzy finder
    telescope-fzf-native-nvim # Native FZF сортировка
    nvim-tree-lua             # Файловый проводник
    harpoon2                  # Быстрая навигация между файлами
    
    # ========== LSP И АВТОДОПОЛНЕНИЕ ==========
    nvim-lspconfig            # Конфигурация LSP
    nvim-cmp                  # Движок автодополнения
    cmp-nvim-lsp              # LSP источник для cmp
    cmp-buffer                # Буфер источник для cmp
    cmp-path                  # Путь источник для cmp
    cmp-cmdline               # Командная строка для cmp
    luasnip                   # Snippet движок
    cmp_luasnip               # Luasnip источник для cmp
    friendly-snippets         # Коллекция снипетов
    
    # ========== TREESITTER ==========
    # Синтаксический анализ и подсветка
    (nvim-treesitter.withPlugins (p: [
      p.nix           # Nix
      p.lua           # Lua
      p.python        # Python
      p.rust          # Rust
      p.javascript    # JavaScript
      p.typescript    # TypeScript
      p.bash          # Bash
      p.json          # JSON
      p.yaml          # YAML
      p.markdown      # Markdown
      p.html          # HTML
      p.css           # CSS
    ]))
    
    # ========== GIT ИНТЕГРАЦИЯ ==========
    gitsigns-nvim             # Git знаки в gutter
    vim-fugitive              # Git команды
    
    # ========== ПОЛЕЗНЫЕ ПЛАГИНЫ ==========
    comment-nvim              # Быстрое комментирование
    nvim-autopairs            # Автозакрытие скобок
    which-key-nvim            # Показывает доступные комбинации
    toggleterm-nvim           # Встроенный терминал
    
    # ========== ФОРМАТИРОВАНИЕ ==========
    conform-nvim              # Форматтер кода
    
    # ========== ЛИНТИНГ ==========
    nvim-lint                 # Линтер
  ];
}