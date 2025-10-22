// System Statistics Widget - CPU, RAM, Temp
// Inspired by end-4/dots-hyprland

const { execAsync } = Utils;

// CPU usage polling
const cpu = Variable(0, {
  poll: [2000,
    "bash -c \"top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\\([0-9.]*\\)%* id.*/\\1/' | awk '{print 100 - $1}'\"",
    out => Number(out) || 0
  ],
});

// RAM usage polling
const ram = Variable(0, {
  poll: [2000,
    "bash -c \"free -m | awk '/Mem:/ {printf \\\"%d\\\", ($3/$2) * 100.0}'\"",
    out => Number(out) || 0
  ],
});

// Temperature polling (if available)
const temp = Variable(0, {
  poll: [2000,
    "bash -c \"sensors 2>/dev/null | grep 'Package id 0:' | awk '{print $4}' | tr -d '+°C' || echo 0\"",
    out => Number(out) || 0
  ],
});

// Stat item
const StatItem = (icon, label, value, color) => Widget.Box({
  class_name: "stat-item",
  spacing: 8,
  children: [
    Widget.Icon({
      icon,
      size: 20,
    }),
    Widget.Box({
      vertical: true,
      vpack: "center",
      children: [
        Widget.Label({
          class_name: "stat-label",
          label,
          xalign: 0,
        }),
        Widget.Box({
          spacing: 8,
          children: [
            Widget.LevelBar({
              class_name: "stat-bar",
              value: value.bind(),
              max_value: 100,
              bar_mode: "continuous",
              css: `
                min-width: 120px;
                min-height: 6px;
              `,
            }),
            Widget.Label({
              class_name: "stat-value",
              label: value.bind().as(v => `${Math.round(v)}%`),
            }),
          ],
        }),
      ],
    }),
  ],
});

// Temperature item (different format)
const TempItem = () => Widget.Box({
  class_name: "stat-item",
  spacing: 8,
  children: [
    Widget.Icon({
      icon: "temperature-symbolic",
      size: 20,
    }),
    Widget.Box({
      vertical: true,
      vpack: "center",
      children: [
        Widget.Label({
          class_name: "stat-label",
          label: "Temperature",
          xalign: 0,
        }),
        Widget.Label({
          class_name: "stat-value",
          label: temp.bind().as(t => t > 0 ? `${Math.round(t)}°C` : "N/A"),
          xalign: 0,
        }),
      ],
    }),
  ],
});

// Main system stats widget
export const SystemStats = () => Widget.Box({
  class_name: "system-stats",
  vertical: true,
  spacing: 12,
  children: [
    Widget.Label({
      class_name: "section-title",
      label: "System",
      xalign: 0,
    }),
    Widget.Box({
      class_name: "stats-container",
      vertical: true,
      spacing: 8,
      children: [
        StatItem("cpu-symbolic", "CPU", cpu, "#e57373"),
        StatItem("memory-symbolic", "RAM", ram, "#64b5f6"),
        TempItem(),
      ],
    }),
  ],
});
