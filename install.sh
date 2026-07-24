#!/usr/bin/env bash

ERRORS=()

run_step() {
  local name="$1"
  shift
  echo "[*] $name..."
  if ! "$@"; then
    echo "[!] FAILED: $name" >&2
    ERRORS+=("$name")
  fi
}

echo "=== Shaaux Install Script ==="
echo ""

# --- TODO: Add install of firefox ---

# TODO: Add install of yazi with all its dependencies

# TODO: Run the Omarchy remove preinstalls script, then install the things i did need from that to debloat

# TODO: Install zsh and set it as default shell

# TODO: Install CLIAmp

# TODO: Install Vesktop, remove discord

# TODO: Install Zathura

# TODO: Remove typora and xournal++

# TODO: Install Insync

# --- Kanata (key remapper) ---
if command -v kanata &>/dev/null; then
  echo "[~] Kanata already installed, skipping package install."
else
  run_step "Installing Kanata via AUR" yay -S --noconfirm kanata
fi

if [ ! -f "$HOME/.config/kanata/kanata.kbd" ]; then
  run_step "Stowing Kanata config" stow .
else
  echo "[~] Kanata config already stowed, skipping."
fi

if ! systemctl --user is-enabled --quiet kanata 2>/dev/null; then
  run_step "Enabling Kanata user service" systemctl --user enable --now kanata
else
  echo "[~] Kanata service already enabled, skipping."
fi

# --- Summary ---
echo ""
if [ ${#ERRORS[@]} -eq 0 ]; then
  echo "=== Done (all steps succeeded) ==="
else
  echo "=== Done with errors ===" >&2
  echo "The following steps failed:" >&2
  for err in "${ERRORS[@]}"; do
    echo "  - $err" >&2
  done
  exit 1
fi
