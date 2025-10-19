{ config, pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    
    # Скрипты для расширенной функциональности
    scripts = with pkgs.mpvScripts; [
      mpris              # MPRIS support для media controls
      thumbnail          # Превью при перемотке
      quality-menu       # Меню выбора качества для YouTube
      autoload           # Автозагрузка файлов из папки
      # sponsorblock     # Пропуск спонсоров на YouTube (опционально)
    ];
    
    config = {
      # ========== GPU & ПРОИЗВОДИТЕЛЬНОСТЬ ==========
      
      # Профиль качества - максимальное качество
      profile = "gpu-hq";
      
      # Video output - лучший для Wayland
      vo = "gpu-next";  # Новый vo для лучшей производительности
      gpu-api = "vulkan";  # Vulkan быстрее чем OpenGL
      hwdec = "auto-safe";  # Hardware декодирование
      
      # Интерполяция кадров для плавности
      video-sync = "display-resample";
      interpolation = true;
      tscale = "oversample";
      
      # ========== КЕШИРОВАНИЕ ==========
      
      # Кеш для сетевых потоков
      cache = true;
      demuxer-max-bytes = "512M";  # 512MB буфер
      demuxer-max-back-bytes = "256M";  # 256MB backward buffer
      
      # ========== АУДИО ==========
      
      # Нормализация громкости
      af = "lavfi=[dynaudnorm=f=75:g=25:p=0.55]";
      
      # Язык аудио (приоритет)
      alang = "ru,rus,en,eng,ja,jpn";
      
      # ========== СУБТИТРЫ ==========
      
      # Автозагрузка субтитров
      sub-auto = "fuzzy";
      slang = "ru,rus,en,eng";
      
      # Шрифт и размер
      sub-font = "Noto Sans";
      sub-font-size = 44;
      sub-color = "#FFFFFFFF";
      sub-border-color = "#FF000000";
      sub-border-size = 3.0;
      sub-shadow-offset = 1;
      sub-shadow-color = "#33000000";
      sub-spacing = 0.5;
      
      # ========== OSD (On-Screen Display) ==========
      
      osd-font = "JetBrainsMono Nerd Font";
      osd-font-size = 32;
      osd-color = "#CCFFFFFF";
      osd-border-color = "#CC000000";
      osd-border-size = 2;
      osd-bar-h = 2;
      osd-bar-align-y = 0.95;
      osd-duration = 2000;
      osd-level = 1;
      
      # ========== СКРИНШОТЫ ==========
      
      screenshot-format = "png";
      screenshot-png-compression = 8;
      screenshot-template = "~/Pictures/Screenshots/mpv_%F_%P";
      screenshot-directory = "~/Pictures/Screenshots";
      
      # Высокое качество скриншотов
      screenshot-high-bit-depth = true;
      screenshot-sw = false;
      
      # ========== ИНТЕРФЕЙС ==========
      
      # Показывать имя файла в заголовке
      title = "\${media-title}";
      
      # Держать окно поверх других при воспроизведении
      ontop = true;
      
      # Автоматически закрывать после окончания
      keep-open = false;
      
      # Сохранять позицию воспроизведения
      save-position-on-quit = true;
      
      # ========== YouTube-DL ==========
      
      # Качество для YouTube
      ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
      
      # ========== ДЕБОРДЕРЫ ==========
      
      # Отключить экранные бордеры
      no-border = false;
      
      # ========== ПРОДВИНУТЫЕ НАСТРОЙКИ ==========
      
      # Deinterlacing
      deinterlace = "auto";
      
      # Дебандинг (убирает полосы на градиентах)
      deband = true;
      deband-iterations = 4;
      deband-threshold = 35;
      deband-range = 16;
      deband-grain = 5;
      
      # Антиалиасинг
      scale = "ewa_lanczossharp";
      cscale = "ewa_lanczossharp";
      dscale = "mitchell";
      
      # HDR
      tone-mapping = "bt.2390";
      hdr-compute-peak = true;
      
      # ========== РАЗНОЕ ==========
      
      # Пауза при минимизации
      pause-on-minimize = true;
      
      # Громкость по умолчанию
      volume = 100;
      volume-max = 150;
    };
    
    # ========== ГОРЯЧИЕ КЛАВИШИ ==========
    bindings = {
      # Навигация
      "WHEEL_UP" = "seek 10";
      "WHEEL_DOWN" = "seek -10";
      "Shift+WHEEL_UP" = "seek 60";
      "Shift+WHEEL_DOWN" = "seek -60";
      
      # Громкость колесиком с Ctrl
      "Ctrl+WHEEL_UP" = "add volume 2";
      "Ctrl+WHEEL_DOWN" = "add volume -2";
      
      # Скорость воспроизведения
      "[" = "add speed -0.1";
      "]" = "add speed 0.1";
      "{" = "multiply speed 0.5";
      "}" = "multiply speed 2.0";
      "BS" = "set speed 1.0";  # Backspace сброс скорости
      
      # Субтитры
      "z" = "add sub-delay -0.1";  # Субтитры раньше
      "x" = "add sub-delay +0.1";  # Субтитры позже
      "c" = "add sub-scale -0.1";  # Меньше субтитры
      "v" = "add sub-scale +0.1";  # Больше субтитры
      
      # Аудио
      "#" = "cycle audio";          # Переключить аудио дорожку
      
      # Видео
      "1" = "add contrast -1";
      "2" = "add contrast 1";
      "3" = "add brightness -1";
      "4" = "add brightness 1";
      "5" = "add gamma -1";
      "6" = "add gamma 1";
      "7" = "add saturation -1";
      "8" = "add saturation 1";
      
      # Скриншоты
      "s" = "screenshot";               # Скриншот с субтитрами
      "S" = "screenshot video";         # Скриншот без субтитров
      "Ctrl+s" = "screenshot window";   # Скриншот всего окна
      
      # Информация
      "i" = "script-binding stats/display-stats";
      "I" = "script-binding stats/display-stats-toggle";
      
      # Плейлист
      "<" = "playlist-prev";
      ">" = "playlist-next";
      
      # Главы (если есть)
      "PGUP" = "add chapter 1";
      "PGDWN" = "add chapter -1";
      
      # Закладки
      "Ctrl+b" = "script-message bookmark-set";
      "b" = "script-message bookmark-load";
      
      # Циклы
      "l" = "ab-loop";  # Set/clear A-B loop
      
      # Rotation
      "Alt+RIGHT" = "cycle-values video-rotate 90 180 270 0";
      "Alt+LEFT" = "cycle-values video-rotate 270 180 90 0";
      
      # Aspect ratio
      "a" = "cycle-values video-aspect-override \"16:9\" \"4:3\" \"2.35:1\" \"-1\"";
    };
    
    # ========== AUTO PROFILES ==========
    profiles = {
      # Профиль для 4K видео
      "4k" = {
        profile-desc = "4K UHD Video";
        profile-cond = "width >= 3840";
        deband = true;
        scale = "ewa_lanczossharp";
      };
      
      # Профиль для аниме
      anime = {
        profile-desc = "Anime Profile";
        profile-cond = "path matches \"anime|Anime|ANIME\"";
        deband = true;
        deband-iterations = 2;
        deband-threshold = 40;
        deband-range = 20;
        deband-grain = 0;
      };
      
      # Профиль для слабого железа (если лагает)
      "low-end" = {
        profile-desc = "Low-end Hardware";
        # Раскомментируй если нужно
        # profile-cond = "true";
        hwdec = "auto-safe";
        vo = "gpu";
        scale = "bilinear";
        cscale = "bilinear";
        dscale = "bilinear";
        interpolation = false;
      };
      
      # Профиль для YouTube/стримов
      stream = {
        profile-desc = "Streaming Video";
        profile-cond = "path matches \"youtube|twitch|stream\"";
        cache = true;
        demuxer-max-bytes = "1024M";
        ytdl-format = "bestvideo[height<=?1080][fps<=?60]+bestaudio/best";
      };
      
      # Профиль для изображений
      image = {
        profile-desc = "Image Viewer";
        profile-cond = "path matches \"\\.(png|jpg|jpeg|webp|gif)$\"";
        keep-open = true;
        video-aspect-override = "-1";
      };
    };
  };
  
  # Дополнительные пакеты для MPV
  home.packages = with pkgs; [
    yt-dlp              # YouTube downloader (новая версия youtube-dl)
    ffmpeg-full         # Полный FFmpeg для всех кодеков
  ];
  
  # Создаём папку для скриншотов
  home.file."Pictures/Screenshots/.keep".text = "";
}