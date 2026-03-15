# Dotfiles

Beed's Linux configuration for a fast, keyboard-driven workflow on Debian.

I install Debian with the [GNOME](https://www.gnome.org/) flavor, then use
[i3wm](https://i3wm.org/) for day-to-day work.

## Installation

This repo uses [GNU Stow](https://www.gnu.org/software/stow/) to create
symlinks from this directory into `$HOME`.

```bash
git clone git@codeberg.org:Beed/.dotfiles.git --depth 1 "$HOME/.dotfiles"
cd "$HOME/.dotfiles"
stow .
```

## What is in this repo

Main configs are in `.config/` and include:

- `alacritty`, `tmux`, `nvim`
- `i3`, `i3blocks`, `rofi`, `picom`, `dunst`
- `mpd`, `mpv`, `nsxiv`, `zathura`
- `kanata`, `espanso`, `fzf`
- `nix`, `wallpaper`, and other desktop/tooling configs

Other notable files:

- `.bashrc` and `.profile` for shell environment, aliases, and PATH setup
- `.mozilla/firefox/user.js` and `.mozilla/firefox/chrome/userChrome.css`
- `srv/` for user services (for example `kanata` and `mpd-mpris`)

## Browser

I use Firefox with:

- `user.js` preferences and `userChrome.css` custom styling from this repo
- Extensions:
  - Link Hints
  - Sidebery
  - uBlock Origin
  - UnTrap for YouTube
  - Video Speed Controller

## Package scripts

This repo has helper scripts in `add/` and `rem/`.

### `add/`

Use `add/` for install/bootstrap helpers on fresh systems.

Run a script directly, for example:

```bash
./add/apt
./add/firefox
./add/neovim
```

`add/README.md` has a full new-system setup guide for Debian.

### `rem/`

`rem/` is currently outdated. Do **not** use `rem/` for now.

If you need to remove software, do it manually until these scripts are refreshed.
