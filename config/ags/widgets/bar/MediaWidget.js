// Media Player Widget - Shows current playing media
// Inspired by end-4/dots-hyprland

const mpris = await Service.import("mpris");

const FALLBACK_ICON = "audio-x-generic-symbolic";
const TRUNCATE_LENGTH = 40;

// Get preferred player or first available
const getPlayer = () => mpris.players[0] || null;

// Media player widget
export const MediaWidget = () => {
  const revealer = Widget.Revealer({
    revealChild: false,
    transition: "slide_right",
    transitionDuration: 300,
    child: Widget.Box({
      class_name: "media",
      spacing: 8,
      children: [
        // Album art
        Widget.Box({
          class_name: "media-cover-art",
          css: mpris.bind("players").as(players => {
            const player = getPlayer();
            if (!player) return "";
            const url = player.cover_path || "";
            return url ? `
              background-image: url('${url}');
              background-size: cover;
              background-position: center;
              min-width: 32px;
              min-height: 32px;
              border-radius: 6px;
            ` : "";
          }),
        }),

        // Track info
        Widget.Box({
          vertical: true,
          children: [
            Widget.Label({
              class_name: "media-title",
              truncate: "end",
              max_width_chars: 30,
              label: mpris.bind("players").as(players => {
                const player = getPlayer();
                return player?.track_title || "Nothing playing";
              }),
            }),
            Widget.Label({
              class_name: "media-artist",
              truncate: "end",
              max_width_chars: 30,
              label: mpris.bind("players").as(players => {
                const player = getPlayer();
                return player?.track_artists.join(", ") || "";
              }),
            }),
          ],
        }),

        // Play/Pause button
        Widget.Button({
          class_name: "media-playpause",
          on_clicked: () => getPlayer()?.playPause(),
          child: Widget.Icon().hook(mpris, self => {
            const player = getPlayer();
            self.icon = player?.play_back_status === "Playing"
              ? "media-playback-pause-symbolic"
              : "media-playback-start-symbolic";
          }),
        }),

        // Next button
        Widget.Button({
          class_name: "media-next",
          on_clicked: () => getPlayer()?.next(),
          child: Widget.Icon("media-skip-forward-symbolic"),
        }),
      ],
    }),
  });

  return Widget.Box({
    children: [revealer],
    setup: self => self.hook(mpris, () => {
      revealer.reveal_child = mpris.players.length > 0;
    }),
  });
};
