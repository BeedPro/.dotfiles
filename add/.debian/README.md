# Dotfiles

Beed's Linux setup for a keyboard-driven workflow on Debian.

I install Debian with [Xfce](https://www.xfce.org/), then run
[i3wm](https://i3wm.org/) for day-to-day use.

## Install

This repo uses [GNU Stow](https://www.gnu.org/software/stow/) to symlink files
into `$HOME`.

```bash
git clone git@codeberg.org:Beed/.dotfiles.git --depth 1 "$HOME/.dotfiles"
cd "$HOME/.dotfiles"
stow .
```

## Debian APT sources for non-free packages

Some scripts need Debian packages outside `main`:

- `add/nvidia` installs `nvidia-driver`.
- `add/steam` installs `steam-installer` and enables `i386` architecture.

Before running those scripts, make sure your Debian repositories include:

- `contrib`
- `non-free`
- `non-free-firmware`

If you use `.sources` files, each Debian source stanza should include:

```text
Components: main contrib non-free non-free-firmware
```

Example `debian.sources` entries:

```text
# Modernized from /etc/apt/sources.list
Types: deb deb-src
URIs: http://deb.debian.org/debian/
Suites: trixie
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

# Modernized from /etc/apt/sources.list
Types: deb deb-src
URIs: http://security.debian.org/debian-security/
Suites: trixie-security
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

# Modernized from /etc/apt/sources.list
Types: deb deb-src
URIs: http://deb.debian.org/debian/
Suites: trixie-updates
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
```

After changing sources, run:

```bash
sudo apt update
```

Also add `non-free` and `contrib` to `/etc/extrepo/config.yaml` when you install `extrepo`.
