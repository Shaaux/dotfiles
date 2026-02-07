# My Dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

### Git

```terminal
pacman -S git
```

### Stow

```terminal
pacman -S stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```terminal
git@github.com:Shaaux/OmarchyDotfiles.git
cd dotfiles
```

Then use GNU stow to create symlinks

```terminal
stow .
```
