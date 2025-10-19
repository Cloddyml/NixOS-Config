// AGS Configuration - Material Design inspired by end-4
// Этот файл нужно поместить в ~/.config/ags/config.js

const hyprland = await Service.import("hyprland");
const notifications = await Service.import("notifications");
const mpris = await Service.import("mpris");
const audio = await Service.import("audio");
const battery = await Service.import("battery");
const systemtray = await Service.import("systemtray");

// Импорт виджетов
import Bar from "./widgets/bar/Bar.js";
import NotificationPopups from "./widgets/notifications/NotificationPopups.js";
import Overview from "./widgets/overview/Overview.js";
import QuickSettings from "./widgets/quicksettings/QuickSettings.js";

// Конфигурация
const CONFIG = {
  bar: {
    position: "top",
    height: 42,
  },
  theme: {
    spacing: 8,
    radius: 12,
  },
};

// Главная конфигурация
App.config({
  style: "./style.css",
  windows: [
    // Bar для каждого монитора
    ...hyprland.monitors.map(monitor => Bar(monitor)),
    
    // Уведомления
    NotificationPopups(),
    
    // Overview (Super+Tab)
    Overview(),
    
    // Quick Settings (Super+A)
    QuickSettings(),
  ],
  
  // Закрываем окна по ESC
  closeWindowDelay: {
    "overview": 200,
    "quicksettings": 200,
  },
});

// Экспорт для глобального доступа
globalThis.CONFIG = CONFIG;