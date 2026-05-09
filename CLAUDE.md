# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a [chezmoi](https://www.chezmoi.io/) managed dotfiles repository for macOS. Chezmoi syncs configurations from this repo to the home directory.

## Key Commands

- `chezmoi apply` — Apply all changes from the repo to the home directory.
- `chezmoi diff` — Show differences between repo and home directory.
- `chezmoi status` — Show which files have changed.
- `chezmoi edit <path>` — Edit a source file (opens in VS Code via `--wait`).
- `chezmoi add <path>` — Add a new file to chezmoi management.
- `chezmoi re-add` — Re-add target files that have changed outside chezmoi.
- `chezmoi doctor` — Diagnose chezmoi installation and configuration.

## Chezmoi Naming Conventions

Source filenames in this repo map to the home directory via chezmoi conventions:

- `dot_` prefix → `.` in the target path (e.g., `dot_zshrc` → `~/.zshrc`, `dot_config/nvim/` → `~/.config/nvim/`).
- `executable_` prefix → file gets executable permission (e.g., `executable_sketchybarrc` → `~/.config/sketchybar/sketchybarrc` with `+x`).

## High-Level Structure

- **dot_config/** — Tool configurations: Neovim, Tmux, Alacritty, Kitty, Ghostty, WezTerm, Helix, Starship, Yazi, Lazygit, Zellij, Sesh, Muxie, SketchyBar, Fastfetch, Btop.
- **dot_config/sketchybar/** — SketchyBar status bar scripts (macOS). All plugin scripts are marked `executable_`.
- **dot_config/yabai/** + **dot_config/skhd/** — macOS window manager (yabai) and hotkey daemon (skhd) configs.
- **dot_config/tmux/** — Tmux config. Requires [TPM](https://github.com/tmux-plugins/tpm) installed at `~/.config/tmux/plugins/tpm`.
- **dot_config/tmuxinator/** — Predefined Tmux session layouts.
- **dot_config/sesh/** + **dot_config/muxie/** — Session manager configs for quick project switching.
- **dot_zshrc** — Zsh configuration. Sources `~/.bash_profile` and uses oh-my-zsh from `~/.config/zsh/.oh-my-zsh`.
- **dot_config/homebrew/Brewfile** — Homebrew bundle file for package management.
- **assets/** — Fonts and images used by configs.

## Editor Configuration

Chezmoi is configured (in `.chezmoi.toml.tmpl`) to use `code --wait` for the `chezmoi edit` command.
