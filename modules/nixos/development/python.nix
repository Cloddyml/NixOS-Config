{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Python
    python3Full
    python312Packages.pip
    python312Packages.virtualenv
    python312Packages.poetry
    
    # Полезные инструменты для Python разработки
    ruff         # Быстрый линтер и форматтер
    uv           # Очень быстрый пакетный менеджер
    pyright      # Language server (уже есть в neovim модуле, но на всякий случай)
  ];
  
  # Переменные окружения для Python
  environment.variables = {
    PYTHONPATH = "$HOME/.local/lib/python3.12/site-packages";
  };
}