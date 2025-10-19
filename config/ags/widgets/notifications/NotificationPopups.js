// Notification Popups Widget
// ~/.config/ags/widgets/notifications/NotificationPopups.js

const notifications = await Service.import("notifications");

const Notification = (n) => {
  const icon = Widget.Icon({
    class_name: "notification-icon",
    icon: n.app_icon || "dialog-information-symbolic",
    size: 48,
  });
  
  const content = Widget.Box({
    class_name: "notification-content",
    vertical: true,
    children: [
      Widget.Box({
        children: [
          Widget.Label({
            class_name: "notification-app",
            label: n.app_name,
            xalign: 0,
            hexpand: true,
          }),
          Widget.Button({
            class_name: "notification-close",
            child: Widget.Icon("window-close-symbolic"),
            on_clicked: () => n.close(),
          }),
        ],
      }),
      Widget.Label({
        class_name: "notification-summary",
        label: n.summary,
        xalign: 0,
        wrap: true,
        max_width_chars: 40,
      }),
      Widget.Label({
        class_name: "notification-body",
        label: n.body,
        xalign: 0,
        wrap: true,
        max_width_chars: 40,
      }),
    ],
  });
  
  return Widget.EventBox({
    on_primary_click: () => n.close(),
    child: Widget.Box({
      class_name: `notification ${n.urgency}`,
      children: [icon, content],
    }),
  });
};

export default () => Widget.Window({
  name: "notifications",
  class_name: "notification-popups",
  anchor: ["top", "right"],
  child: Widget.Box({
    class_name: "notifications-container",
    vertical: true,
    spacing: 8,
    css: "padding: 8px;",
    children: notifications.bind("popups").as(popups => 
      popups.map(Notification)
    ),
  }),
});