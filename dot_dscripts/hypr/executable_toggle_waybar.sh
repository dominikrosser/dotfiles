
#!/bin/bash

# Toggle Waybar visibility using Sway IPC
if pgrep -x waybar >/dev/null; then
    swaymsg '[class="Waybar"] kill'
else
    waybar &
fi
