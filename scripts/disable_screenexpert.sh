#!/bin/bash

if type "xrandr" >/dev/null; then
  XRANDR_OUTPUT=$(xrandr)

  if echo "$XRANDR_OUTPUT" | grep -q "HDMI-1 connected 1080x2160+1920+0"; then
    xrandr --output HDMI-1 --off
  fi
fi
