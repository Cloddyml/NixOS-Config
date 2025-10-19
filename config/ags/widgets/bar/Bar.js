// Bar Widget - Material Design Style
// ~/.config/ags/widgets/bar/Bar.js

const hyprland = await Service.import("hyprland");
const audio = await Service.import("audio");
const battery = await Service.import("battery");
const systemtray = await Service.import("systemtray");
const date = Variable("", {
  poll: [1000, 'date "+%H:%M  %b %e"'],
});

// Workspaces widget
const Workspaces = () => Widget.Box({
  class_name: "workspaces",
  children: Array.from({ length: 10 }, (_, i) => i + 1).map(i => Widget.Button({
    attribute: i,
    label: `${i}`,
    on_clicked: () => hyprland.messageAsync(`dispatch workspace ${i}`),
    setup: self => self.hook(hyprland, () => {
      self.toggleClassName("active", hyprland.active.workspace.id === i);
      self.toggleClassName("occupied", (hyprland.getWorkspace(i)?.windows || 0) > 0);
    }),
  })),
});

// Client Title widget
const ClientTitle = () => Widget.Label({
  class_name: "client-title",
  label: hyprland.active.client.bind("title").as(title => 
    title.length > 50 ? title.substring(0, 50) + "..." : title
  ),
});

// Clock widget
const Clock = () => Widget.Label({
  class_name: "clock",
  label: date.bind(),
});

// Volume widget
const Volume = () => Widget.Button({
  class_name: "volume",
  on_clicked: () => audio.speaker.is_muted = !audio.speaker.is_muted,
  child: Widget.Icon().hook(audio.speaker, self => {
    const vol = audio.speaker.volume * 100;
    const icon = [
      [101, "overamplified"],
      [67, "high"],
      [34, "medium"],
      [1, "low"],
      [0, "muted"],
    ].find(([threshold]) => threshold <= vol)?.[1];
    
    self.icon = `audio-volume-${icon}-symbolic`;
    self.tooltip_text = `Volume ${Math.floor(vol)}%`;
  }),
});

// Battery widget
const Battery = () => Widget.Box({
  class_name: "battery",
  visible: battery.bind("available"),
  children: [
    Widget.Icon({ icon: battery.bind("icon_name") }),
    Widget.Label({ label: battery.bind("percent").as(p => `${p}%`) }),
  ],
});

// System Tray
const SysTray = () => Widget.Box({
  class_name: "systray",
  children: systemtray.bind("items").as(items => items.map(item => Widget.Button({
    child: Widget.Icon({ icon: item.bind("icon") }),
    on_primary_click: (_, event) => item.activate(event),
    on_secondary_click: (_, event) => item.openMenu(event),
    tooltip_markup: item.bind("tooltip_markup"),
  }))),
});

// Left side of bar
const Left = () => Widget.Box({
  spacing: 8,
  children: [
    Workspaces(),
    ClientTitle(),
  ],
});

// Center of bar
const Center = () => Widget.Box({
  spacing: 8,
  children: [
    Clock(),
  ],
});

// Right side of bar
const Right = () => Widget.Box({
  hpack: "end",
  spacing: 8,
  children: [
    Volume(),
    Battery(),
    SysTray(),
  ],
});

// Main Bar
export default (monitor = 0) => Widget.Window({
  name: `bar-${monitor}`,
  class_name: "bar",
  monitor,
  anchor: ["top", "left", "right"],
  exclusivity: "exclusive",
  child: Widget.CenterBox({
    class_name: "bar-container",
    start_widget: Left(),
    center_widget: Center(),
    end_widget: Right(),
  }),
});