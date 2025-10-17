
{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Node.js и пакетные менеджеры
    nodejs_22
    nodePackages.npm
    nodePackages.pnpm
    nodePackages.yarn
    
    # Полезные глобальные пакеты
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.prettier
  ];
  
  # Переменные окружения для npm
  environment.variables = {
    NPM_CONFIG_PREFIX = "$HOME/.npm-global";
  };
  
  environment.shellInit = ''
    export PATH="$HOME/.npm-global/bin:$PATH"
  '';
}