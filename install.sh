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

# --- Add more install commands below ---

echo ""
echo "=== Done ==="
