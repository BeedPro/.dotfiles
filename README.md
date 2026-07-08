For partitioning and disk setup during a fresh install, see [`INSTALL.md`](./INSTALL.md).

These steps assume the base Void live image, the one that boots to a TTY.

## Fresh Install Flow

### Install Void

From the live image, log in as `root` and start the installer:

```bash
void-installer
```

Use `INSTALL.md` as the partitioning reference.

After the install finishes, reboot into the installed system.

### Update The Base System

Log in to the installed system and update XBPS first:

```bash
sudo xbps-install -Syu xbps
sudo xbps-install -Syu
```

Install the minimal tools needed to fetch and apply this repo:

```bash
sudo xbps-install -S git neovim curl stow
```

Clone the repo:

```bash
git clone https://github.com/BeedPro/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### Install The Desktop

Install XFCE, Xorg, LightDM, PipeWire, Bluetooth, and NetworkManager:

```bash
add/xfce4
```

This script reboots when it finishes.

### Install Graphics Drivers

After rebooting, choose the script for the machine.

For NVIDIA systems:

```bash
cd ~/.dotfiles
add/nvidia
```

For AMD systems:

```bash
cd ~/.dotfiles
add/amd
```

These scripts reboot when they finish. Do not run both unless the machine intentionally needs both driver stacks.

### Set Up GitHub

After rebooting, set up GitHub SSH:

```bash
cd ~/.dotfiles
add/github
```

The script copies the new public key to the clipboard and waits while you add it to GitHub.

### Apply Dotfiles

After GitHub is set up and the repo origin has been switched to SSH:

```bash
cd ~/.dotfiles
stow .
```

### Install The Rest

Install the base app/tool groups:

```bash
add/cli
add/tui
add/gui
```

Install development tools:

```bash
add/devtools
add/haskell
add/uv
add/ai
```

Install standalone extras:

```bash
add/espanso
add/void-packages
add/themes
add/firefox
add/i3wm
add/gaming
add/flathub
```

## Optional Scripts

Run this only inside a QEMU guest:

```bash
add/qemu-kvm.guest
```

Run this on laptops where TLP power management is wanted:

```bash
add/powerman
```

## Laptop Lid Suspend

For laptop suspend behavior, disable the `acpid` service and let `xfce4-power-manager` handle lid close:

```bash
sudo rm /var/service/acpid
```

Then make sure `/etc/elogind/logind.conf` contains:

```ini
[Login]
HandleLidSwitch=suspend
HandleLidSwitchExternalPower=suspend
HandleLidSwitchDocked=ignore
```
