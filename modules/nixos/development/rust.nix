{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Rust toolchain
    rustc
    cargo
    rustfmt
    rust-analyzer
    clippy
    
    # Дополнительные инструменты
    cargo-watch    # Автоматический rebuild
    cargo-edit     # Cargo add, rm, upgrade
    cargo-outdated # Проверка устаревших зависимостей
  ];
}