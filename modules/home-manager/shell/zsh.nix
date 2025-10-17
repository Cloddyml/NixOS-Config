{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      # LS замены
      ll = "eza -la --icons";
      la = "eza -la --icons";
      ls = "eza --icons";
      lt = "eza --tree --icons";
      
      # Cat замены
      cat = "bat";
      
      # Grep замены
      grep = "rg";
      
      # Find замены
      find = "fd";
      
      # NixOS специфичные
      rebuild = "sudo nixos-rebuild switch --flake ~/.config/nixos#$(hostname)";
      update = "sudo nix flake update ~/.config/nixos";
      clean = "sudo nix-collect-garbage -d";
      
      # Git сокращения
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gs = "git status";
      gd = "git diff";
    };
    
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    
    initExtra = ''
      # Vi mode
      bindkey -v
      
      # Улучшенная навигация
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down
      
      # Быстрое редактирование команды
      autoload -U edit-command-line
      zle -N edit-command-line
      bindkey '^e' edit-command-line
    '';
  };
}