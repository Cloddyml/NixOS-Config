{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # Основные утилиты
    fastfetch
    btop
    ranger
    tree
    
    # Поиск и навигация
    fd
    ripgrep
    jq
    
    # Файлы и архивы
    unzip
    zip
    p7zip

    # Wayland инструменты
    wl-clipboard

    # Мультимедиа
    cava
    imv
  ];
  
  # Bat - улучшенный cat
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      style = "numbers,changes,header";
    };
  };
  
  # Eza - улучшенный ls
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    icons = "auto";
  };
  
  # Fzf - fuzzy finder
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    colors = {
      bg = "#1e1e2e";
      "bg+" = "#313244";
      fg = "#cdd6f4";
      "fg+" = "#cdd6f4";
    };
  };
  
  # Zoxide - умный cd
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  
  # Direnv для проектов
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}