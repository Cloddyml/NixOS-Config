// Overview Widget - Window Management
// ~/.config/ags/widgets/overview/Overview.js

const hyprland = await Service.import("hyprland");

const WINDOW_REVEAL_DELAY = 14;

// Создаём превью окна
const WindowPreview = (client) => Widget.Button({
  class_name: "window-preview",
  on_clicked: () => {
    hyprland.messageAsync(`dispatch focuswindow address:${client.address}`);
    App.closeWindow("overview");
  },
  child: Widget.Box({
    vertical: true,
    children: [
      // Иконка и заголовок
      Widget.Box({
        class_name: "window-header",
        children: [
          Widget.Icon({
            icon: client.class,
            size: 32,
          }),
          Widget.Label({
            class_name: "window-title",
            label: client.title,
            truncate: "end",
            max_width_chars: 30,
          }),
        ],
      }),
      // Превью окна (placeholder)
      Widget.Box({
        class_name: "window-thumbnail",
        css: `
          min-width: 300px;
          min-height: 200px;
          background: rgba(255, 255, 255, 0.05);
        `,
        child: Widget.Label({
          label: "🪟",
          css: "font-size: 48px;",
        }),
      }),
    ],
  }),
});

// Workspace section
const WorkspaceSection = (workspace) => {
  const clients = hyprland.clients.filter(c => c.workspace.id === workspace.id);
  
  if (clients.length === 0) return null;
  
  return Widget.Box({
    class_name: "workspace-section",
    vertical: true,
    children: [
      Widget.Label({
        class_name: "workspace-label",
        label: `Workspace ${workspace.id}`,
        xalign: 0,
      }),
      Widget.Box({
        class_name: "workspace-windows",
        spacing: 12,
        children: clients.map(WindowPreview),
      }),
    ],
  });
};

// Search bar
const SearchBar = () => {
  const entry = Widget.Entry({
    class_name: "search-entry",
    placeholder_text: "Search windows...",
    on_accept: ({ text }) => {
      if (!text) return;
      // TODO: фильтрация окон
    },
  });
  
  return Widget.Box({
    class_name: "search-bar",
    children: [
      Widget.Icon({ icon: "system-search-symbolic" }),
      entry,
    ],
  });
};

// Main Overview content
const OverviewContent = () => Widget.Scrollable({
  class_name: "overview-content",
  vscroll: "automatic",
  hscroll: "never",
  child: Widget.Box({
    vertical: true,
    spacing: 24,
    children: hyprland.bind("workspaces").as(workspaces => 
      workspaces
        .map(WorkspaceSection)
        .filter(w => w !== null)
    ),
  }),
});

// Main Overview window
export default () => Widget.Window({
  name: "overview",
  class_name: "overview",
  layer: "overlay",
  keymode: "exclusive",
  visible: false,
  anchor: ["top", "bottom", "left", "right"],
  
  setup: self => self.keybind("Escape", () => App.closeWindow("overview")),
  
  child: Widget.Box({
    class_name: "overview-container",
    vertical: true,
    css: "padding: 60px;",
    children: [
      SearchBar(),
      OverviewContent(),
    ],
  }),
});