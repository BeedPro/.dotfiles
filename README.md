# Dotfiles

These are my personal configuration files I use on my Debian system. My workflow is keyboard-driven and focusses on being as simple as possible, resulting in my environment to feel performant. I use the [GNOME](https://www.gnome.org/) flavour of Debian for the base when installing the distro but typically use [dwm](https://dwm.suckless.org/) on the day-to-day.

## Installation

Installing the dotfiles is done using the [GNU Stow](https://www.gnu.org/software/stow/) application that creates soft simlinks of the current directory to the parent directory:

```bash
git clone git@codeberg.org:Beed/.dotfiles.git --depth 1 $HOME/.dotfiles
cd $HOME/.dotfiles
stow .
```
