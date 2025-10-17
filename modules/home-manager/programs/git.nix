{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "couguar";
    userEmail = "ingluemlp@gmail.com";
    
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
      pull.rebase = false;
      
      # Красивый вывод
      color.ui = "auto";
      
      # Полезные алиасы
      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        ci = "commit";
        unstage = "reset HEAD --";
        last = "log -1 HEAD";
        visual = "log --graph --oneline --decorate --all";
      };
    };
    
    # Delta для красивых diff
    delta = {
      enable = true;
      options = {
        navigate = true;
        light = false;
        line-numbers = true;
        side-by-side = true;
      };
    };
  };
  
  # Lazygit - TUI для git (опционально)
  programs.lazygit = {
    enable = true;
    settings = {
      gui.theme = {
        lightTheme = false;
        activeBorderColor = [ "blue" "bold" ];
      };
    };
  };
}