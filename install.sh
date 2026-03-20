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

# --- Brave Browser ---
if command -v brave &>/dev/null || command -v brave-browser &>/dev/null; then
  echo "[~] Brave already installed, skipping."
else
  run_step "Installing Brave Browser" bash -c 'curl -fsS https://dl.brave.com/install.sh | sh'
fi

# --- Tmux Plugin Manager ---
if [ -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "[~] TPM already installed, skipping."
else
  run_step "Installing Tmux Plugin Manager (TPM)" \
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# --- Kanata (key remapper) ---
if command -v kanata &>/dev/null; then
  echo "[~] Kanata already installed, skipping package install."
else
  run_step "Installing Kanata via AUR" yay -S --noconfirm kanata
fi

if [ ! -f "$HOME/.config/kanata/kanata.kbd" ]; then
  run_step "Stowing Kanata config" stow -d ~/dotfiles -t ~ kanata
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
