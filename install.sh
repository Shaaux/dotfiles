#!/usr/bin/env bash
set -e

echo "=== Shaaux Install Script ==="
echo ""

# --- Brave Browser ---
echo "[*] Installing Brave Browser..."
curl -fsS https://dl.brave.com/install.sh | sh

# --- Tmux Plugin Manager ---
echo "[*] Installing Tmux Plugin Manager (TPM)..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# --- Kanata (key remapper) ---
echo "[*] Installing Kanata..."
yay -S --noconfirm kanata
stow -d ~/dotfiles -t ~ kanata
systemctl --user enable --now kanata

# --- Add more install commands below ---

echo ""
echo "=== Done ==="
