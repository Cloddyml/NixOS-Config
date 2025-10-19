// Quick Settings Widget - Sidebar
// ~/.config/ags/widgets/quicksettings/QuickSettings.js

const audio = await Service.import("audio");
const network = await Service.import("network");
const bluetooth = await Service.import("bluetooth");

const { execAsync } = Utils;

// Header
const Header = () => Widget.Box({
  class_name: "qs-header",
  children: [
    Widget.Label({
      class_name: "qs-title",
      label: "Quick Settings",
      hexpand: true,
      xalign: 0,
    }),
    Widget.Button({
      class_name: "qs-close",
      child: Widget.Icon("window-close-symbolic"),
      on_clicked: () => App.closeWindow("quicksettings"),
    }),
  ],
});

// Volume slider
const VolumeSlider = () => Widget.Box({
  class_name: "slider-box",
  vertical: true,
  children: [
    Widget.Box({
      children: [
        Widget.Icon({ icon: "audio-volume-high-symbolic" }),
        Widget.Label({
          label: "Volume",
          hexpand: true,
          xalign: 0,
        }),
        Widget.Label({
          label: audio.speaker.bind("volume").as(v => `${Math.round(v * 100)}%`),
        }),
      ],
    }),
    Widget.Slider({
      class_name: "volume-slider",
      draw_value: false,
      hexpand: true,
      value: audio.speaker.bind("volume"),
      on_change: ({ value }) => audio.speaker.volume = value,
    }),
  ],
});

// Brightness slider
const BrightnessSlider = () => {
  const brightness = Variable(0.5, {
    poll: [1000, "brightnessctl g", out => {
      const max = Number(Utils.exec("brightnessctl m"));
      return Number(out) / max;
    }],
  });
  
  return Widget.Box({
    class_name: "slider-box",
    vertical: true,
    children: [
      Widget.Box({
        children: [
          Widget.Icon({ icon: "display-brightness-symbolic" }),
          Widget.Label({
            label: "Brightness",
            hexpand: true,
            xalign: 0,
          }),
          Widget.Label({
            label: brightness.bind().as(v => `${Math.round(v * 100)}%`),
          }),
        ],
      }),
      Widget.Slider({
        class_name: "brightness-slider",
        draw_value: false,
        hexpand: true,
        value: brightness.bind(),
        on_change: ({ value }) => {
          execAsync(`brightnessctl set ${Math.round(value * 100)}%`);
        },
      }),
    ],
  });
};

// Quick toggle button
const QuickToggle = (icon, label, state, onClick) => Widget.Button({
  class_name: "quick-toggle",
  on_clicked: onClick,
  child: Widget.Box({
    vertical: true,
    children: [
      Widget.Icon({ 
        icon,
        size: 32,
      }),
      Widget.Label({ label }),
    ],
  }),
  setup: self => self.hook(state, () => {
    self.toggleClassName("active", state.value);
  }),
});

// Quick toggles
const QuickToggles = () => Widget.Box({
  class_name: "quick-toggles",
  spacing: 8,
  children: [
    QuickToggle(
      "network-wireless-symbolic",
      "Wi-Fi",
      network.wifi.bind("enabled"),
      () => network.toggleWifi()
    ),
    QuickToggle(
      "bluetooth-symbolic",
      "Bluetooth",
      bluetooth.bind("enabled"),
      () => bluetooth.toggle()
    ),
    QuickToggle(
      "night-light-symbolic",
      "Night Light",
      Variable(false),
      () => execAsync("hyprshade toggle")
    ),
  ],
});

// Main content
const Content = () => Widget.Box({
  class_name: "qs-content",
  vertical: true,
  spacing: 16,
  children: [
    Header(),
    QuickToggles(),
    VolumeSlider(),
    BrightnessSlider(),
  ],
});

// Main Quick Settings window
export default () => Widget.Window({
  name: "quicksettings",
  class_name: "quicksettings",
  layer: "overlay",
  keymode: "exclusive",
  visible: false,
  anchor: ["top", "right"],
  
  setup: self => self.keybind("Escape", () => App.closeWindow("quicksettings")),
  
  child: Widget.Box({
    class_name: "quicksettings-container",
    css: "min-width: 400px; padding: 20px;",
    child: Content(),
  }),
});