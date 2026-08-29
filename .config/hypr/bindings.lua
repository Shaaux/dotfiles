-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Apps not covered by an Omarchy default binding.
o.bind("SUPER + SHIFT + M", "Music", "omarchy-launch-or-focus spotify")
o.bind("SUPER + SHIFT + N", "Editor", "omarchy-launch-editor")
o.bind("SUPER + SHIFT + D", "Docker", "omarchy-launch-tui lazydocker")
o.bind("SUPER + SHIFT + O", "Obsidian", "omarchy-launch-or-focus ^obsidian$ \"uwsm-app -- obsidian\"")
o.bind("SUPER + SHIFT + C", "Calendar", "omarchy-launch-webapp \"https://calendar.google.com\"")
o.bind("SUPER + SHIFT + E", "Email", "omarchy-launch-webapp \"https://mail.google.com\"")
o.bind("SUPER + SHIFT + G", "Messenger", "omarchy-launch-or-focus-webapp \"Messenger\" \"https://www.facebook.com/messages\"")
o.bind("SUPER + SHIFT + P", "Google Photos", "omarchy-launch-or-focus-webapp \"Google Photos\" \"https://photos.google.com/\"")
o.bind("SUPER + SHIFT + ALT + X", "X Post", "omarchy-launch-webapp \"https://x.com/compose/post\"")
o.bind("SUPER + SHIFT + ALT + S", "Screenrecording", "omarchy-menu screenrecord")
o.bind("SUPER + ALT + C", "Color picker", "pkill hyprpicker || hyprpicker -a")
o.bind("SUPER + CTRL + P", "Extract text (OCR) from screenshot", "omarchy-capture-text-extraction")

-- Overrides of Omarchy defaults.
hl.unbind("SUPER + SHIFT + A")
o.bind("SUPER + SHIFT + A", "Claude", "omarchy-launch-webapp \"https://claude.ai\"")

hl.unbind("SUPER + SHIFT + S")
o.bind("SUPER + SHIFT + S", "Screenshot", "omarchy-capture-screenshot")

-- Personal tmux keybindings cheatsheet. Not on SUPER+ALT+K since Omarchy's
-- own "Tmux keybindings" popup lives there by default.
o.bind("SUPER + ALT + SHIFT + K", "Shaaux bindings", "~/.config/hypr/scripts/shaaux-bindings")
