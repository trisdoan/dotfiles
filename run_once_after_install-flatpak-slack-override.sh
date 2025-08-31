#!/bin/bash

# Grant Slack access to Wayland
# see https://github.com/flathub/com.slack.Slack/issues/320
flatpak override --user --socket=wayland com.slack.Slack
