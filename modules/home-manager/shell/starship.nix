{ config, pkgs, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    
    settings = {
      # ========== ОБЩИЕ НАСТРОЙКИ ==========
      add_newline = true;
      format = "$all";
      
      # ========== СИМВОЛЫ СТАТУСА ==========
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
        vimcmd_symbol = "[←](bold green)";
      };
      
      # ========== КОМАНДНАЯ СТРОКА ==========
      cmd_duration = {
        min_time = 500;
        format = "took [$duration](bold yellow) ";
      };
      
      # ========== ДИРЕКТОРИЯ ==========
      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        format = "[$path]($style)[$read_only]($read_only_style) ";
        style = "bold cyan";
      };
      
      # ========== GIT ==========
      git_branch = {
        format = "on [$symbol$branch]($style) ";
        symbol = " ";
        style = "bold purple";
      };
      
      git_status = {
        format = "([$all_status$ahead_behind]($style) )";
        style = "bold red";
        conflicted = "🏳";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        untracked = "?\${count}";
        stashed = "$";
        modified = "!\${count}";
        staged = "+\${count}";
        renamed = "»\${count}";
        deleted = "✘\${count}";
      };
      
      git_commit = {
        commit_hash_length = 7;
        format = "[\\($hash$tag\\)]($style) ";
        style = "bold green";
      };
      
      # ========== ЯЗЫКИ ПРОГРАММИРОВАНИЯ ==========
      
      # Python
      python = {
        symbol = " ";
        format = "via [\${symbol}\${pyenv_prefix}(\${version} )(\\($virtualenv\\) )]($style)";
        style = "yellow bold";
        pyenv_version_name = false;
      };
      
      # Rust
      rust = {
        symbol = " ";
        format = "via [\${symbol}(\${version} )]($style)";
        style = "bold red";
      };
      
      # Node.js
      nodejs = {
        symbol = " ";
        format = "via [\${symbol}(\${version} )]($style)";
        style = "bold green";
      };
      
      # Nix
      nix_shell = {
        symbol = " ";
        format = "via [\${symbol}\${state}( \\($name\\))]($style) ";
        style = "bold blue";
      };
      
      # Docker
      docker_context = {
        symbol = " ";
        format = "via [\${symbol}\${context}]($style) ";
        style = "blue bold";
      };
      
      # ========== СИСТЕМНАЯ ИНФОРМАЦИЯ ==========
      
      # Hostname (показывать только при SSH)
      hostname = {
        ssh_only = true;
        format = "[@$hostname](bold red) ";
      };
      
      # Username (показывать только root)
      username = {
        format = "[$user]($style) ";
        style_user = "bold yellow";
        style_root = "bold red";
        show_always = false;
      };
      
      # Время (опционально)
      time = {
        disabled = true;
        format = "at [$time]($style) ";
        style = "bold white";
      };
      
      # ========== PACKAGE MANAGERS ==========
      
      package = {
        disabled = false;
        symbol = " ";
        format = "via [\${symbol}\${version}]($style) ";
      };
      
      # ========== БАТАРЕЯ (для ноутбуков) ==========
      
      battery = {
        full_symbol = "";
        charging_symbol = "";
        discharging_symbol = "";
        unknown_symbol = "";
        empty_symbol = "";
        
        display = [
          {
            threshold = 10;
            style = "bold red";
          }
          {
            threshold = 30;
            style = "bold yellow";
          }
        ];
      };
      
      # ========== ПАМЯТЬ ==========
      
      memory_usage = {
        disabled = true;
        threshold = 75;
        format = "via $symbol[\${ram}( | \${swap})]($style) ";
        symbol = " ";
        style = "bold dimmed white";
      };
    };
  };
}