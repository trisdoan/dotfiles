-- Turn off defaults for software that is not installed here.
hl.unbind("SUPER + SHIFT + SLASH")   -- 1Password
hl.unbind("SUPER + SHIFT + ALT + B") -- private browser window

-- Slack instead of the default Google Maps webapp.
hl.unbind("SUPER + SHIFT + S")
o.bind("SUPER + SHIFT + S", "Slack", { launch = "flatpak run com.slack.Slack" })

-- Screenshots and recordings on F8 instead of PrintScreen.
hl.unbind("PRINT")
hl.unbind("ALT + PRINT")
o.bind("F8", "Screenshot of region", "omarchy-capture-screenshot region")
o.bind("SHIFT + F8", "Screenshot of window", "omarchy-capture-screenshot windows")
o.bind("ALT + F8", "Screen record a region", "omarchy-capture-screenrecording")
o.bind("CTRL + ALT + F8", "Screen record display", "omarchy-capture-screenrecording --fullscreen")

-- Window control on the physical Super key (ALT in config terms, because
-- input.lua swaps Alt and Super).
o.bind("ALT + F", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
o.bind("ALT + H", "Focus on left window", hl.dsp.focus({ direction = "l" }))
o.bind("ALT + J", "Focus on below window", hl.dsp.focus({ direction = "d" }))
o.bind("ALT + K", "Focus on above window", hl.dsp.focus({ direction = "u" }))
o.bind("ALT + L", "Focus on right window", hl.dsp.focus({ direction = "r" }))
