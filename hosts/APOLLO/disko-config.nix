# Disko configuration for APOLLO - Lenovo ThinkBook 15 ITL G2
# Воссоздает текущую разметку диска декларативно
# 
# ВНИМАНИЕ: Это конфигурация для будущих установок!
# НЕ применяйте её на текущей системе - она сотрет диск!

{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";  # NixOS диск
        content = {
          type = "gpt";
          partitions = {
            # EFI Boot раздел (1GB)
            ESP = {
              priority = 1;
              size = "1G";
              type = "EF00";  # EFI System Partition
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                  "umask=0077"  # Ограничение прав доступа
                ];
              };
            };
            
            # Swap раздел (16GB)
            swap = {
              priority = 2;
              size = "16G";
              content = {
                type = "swap";
                discardPolicy = "both";  # TRIM для SSD
                resumeDevice = true;     # Поддержка гибернации
              };
            };
            
            # Root раздел (остальное место)
            root = {
              priority = 3;
              size = "100%";  # Используем все оставшееся место
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
                mountOptions = [
                  "defaults"
                  "noatime"     # Оптимизация для SSD
                ];
              };
            };
          };
        };
      };
    };
  };
  
  # Примечания:
  # - Windows диск (nvme1n1) не затрагивается
  # - Конфигурация совпадает с текущей разметкой
  # - Для применения при новой установке используйте:
  #   sudo nix run github:nix-community/disko -- --mode disko ./hosts/APOLLO/disko-config.nix
}
