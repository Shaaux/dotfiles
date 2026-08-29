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

# --- keyd (key remapper: Left Alt + ; ' [ types æ ø å, caps/esc swapped) ---
if command -v keyd &>/dev/null; then
  echo "[~] keyd already installed, skipping package install."
else
  run_step "Installing keyd" sudo pacman -S --noconfirm keyd
fi

if [ ! -f "$HOME/.XCompose" ]; then
  run_step "Stowing dotfiles" stow .
else
  echo "[~] Dotfiles already stowed, skipping."
fi

if ! sudo cmp -s etc/keyd/default.conf /etc/keyd/default.conf; then
  run_step "Installing keyd config" sudo install -Dm644 etc/keyd/default.conf /etc/keyd/default.conf
else
  echo "[~] keyd config already up to date, skipping."
fi

if ! systemctl is-enabled --quiet keyd 2>/dev/null; then
  run_step "Enabling keyd service" sudo systemctl enable --now keyd
else
  run_step "Reloading keyd config" sudo keyd reload
fi

run_step "Applying XCompose sequences" omarchy-restart-xcompose

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
