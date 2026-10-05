-- Turn off defaults for software that is not installed here.
hl.unbind("SUPER + SHIFT + SLASH")   -- 1Password
hl.unbind("SUPER + SHIFT + ALT + B") -- private browser window

-- Slack instead of the default Google Maps webapp.
hl.unbind("SUPER + SHIFT + S")
o.bind("SUPER + SHIFT + S", "Slack", { launch = "flatpak run com.slack.Slack" })
