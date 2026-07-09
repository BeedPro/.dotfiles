For partitioning and disk setup during a fresh install, see
[`INSTALL.md`](./INSTALL.md).

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

Before running any `add/` script, update the system yourself:

```bash
sudo xbps-install -Syu
```

The `add/` scripts install their own packages, but they do not run a full
system update.

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

## Set Up GitHub And Codeberg

After rebooting, set up GitHub and Codeberg SSH:

```bash
cd ~/.dotfiles
add/pack/github
add/pack/codeberg
```

The script copies the new public key to the clipboard and waits while you add
it to GitHub and Codeberg.

### Apply Dotfiles

After GitHub and Codeberg is set up and the repo origin has been switched to SSH:

```bash
cd ~/.dotfiles
stow .
```

### Install Applications

Install the terminal and graphical applicatons:

```bash
add/app/cli
add/app/gui
add/app/i3wm
```

This installs the general tools needed for common CLI workflows, development
and productivity. This does not install gaming related packages. To install those please do:

```bash
add/pack/gaming
```

### Install Standalone Components

Each script owns the dependencies for the matching config or tool. Run only what the machine needs.

Terminal and editor components:

```bash
add/pack/shell
add/pack/tmux
add/pack/nvim
add/pack/mpd
add/pack/emacs
```

Language and toolchain components:

```bash
add/lang/rust
add/lang/node
add/lang/java
add/lang/python
add/lang/haskell
add/lang/typst
add/lang/tex
add/lang/prolog
add/lang/sdkman
add/pack/godot
```

Desktop app components:

```bash
add/app/gui
add/app/i3wm
add/pack/firefox
add/pack/themes
add/pack/readers
add/pack/media
add/flathub
add/pack/flatseal
add/pack/vorta
```

Standalone extras:

```bash
add/pack/ai
add/pack/codeberg
add/pack/espanso
add/pack/gaming
add/pack/void-packages
add/pack/wireguard
```

`add/app/i3wm` assumes `add/xfce4` has already been run. It only installs the
i3-specific pieces on top of the XFCE/Xorg/PipeWire base.

`add/pack/nvim` installs the minimal system dependencies for the base Neovim
setup. Optional language servers and formatters that Mason can manage are left
to Mason; the language scripts only install general system/runtime
dependencies.

## Optional Scripts

Run this on a QEMU/KVM host or guest:

```bash
add/qemu-kvm
```

Run this on laptops where TLP power management is wanted:

```bash
add/powerman
```

## Laptop Lid Suspend

For laptop suspend behavior, disable the `acpid` service and let
`xfce4-power-manager` handle lid close:

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
