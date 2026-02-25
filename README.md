# My Dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

### Git

```bash
pacman -S git
```

### Stow

```bash
pacman -S stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```bash
git@github.com:Shaaux/OmarchyDotfiles.git
cd dotfiles
```

Then use GNU stow to create symlinks

```bash
stow .
```

If there are conflicts do this:

```bash
# 2. Run stow with --adopt
# This moves the EXISTING system files INTO ~/dotfiles, then creates symlinks
stow --adopt .
# 3. Restore your dotfiles repo versions (overwriting whatever --adopt pulled in)
cd ~/dotfiles && git checkout .
```
