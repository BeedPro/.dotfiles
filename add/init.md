# Debian New System Setup

This is a guide on setting up a new debian system, as of writing this is for Debian Trixie and so all examples are in that version.

## Configure APT sources

### Main repositories

Edit `/etc/apt/sources.list` and add `contrib, non-free`:

```
# Debian Trixie main repositories
deb http://deb.debian.org/debian/ trixie main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ trixie main contrib non-free non-free-firmware

# Security updates
deb http://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security trixie-security main contrib non-free non-free-firmware

# Point release updates
deb http://deb.debian.org/debian/ trixie-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ trixie-updates main contrib non-free non-free-firmware
```

### Backports

Create `/etc/apt/sources.list.d/debian-backports.sources`:

```
Types: deb deb-src
URIs: http://deb.debian.org/debian
Suites: trixie-backports
Components: main
Enabled: yes
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
```

### Refresh and clean

```
apt modernize-sources
rm -rf /etc/apt/sources.list.bak
rm -rf /etc/apt/sources.list.d/*.bak
apt update
```

## Base system packages

This is to setup the dotfiles

```
apt install vim git git-lfs curl
```

### NVIDIA

```
apt install linux-headers-generic
apt install nvidia-detect
apt install nvidia-open-kernel-dkms nvidia-driver
```

## GRUB configuration

If you are dual booting Windows and you installed Debian after installing
Windows you may want the boot loader to be on the GRUB screen.

Edit `/etc/default/grub`:

```
GRUB_DISABLE_OS_PROBER=false
```

Then regenerate GRUB as usual.

## Zsh as default shell

```
chsh -s /usr/bin/zsh
```

Log out and back in for the change to take effect.

## Codeberg SSH setup

### Create key

```
cd ~/.ssh
ssh-keygen -t ed25519 -a 100 -f codeberg
ssh-add codeberg
```

### SSH config

Add to `~/.ssh/config`:

```
Host codeberg.org
  HostName codeberg.org
  User git
  IdentityFile ~/.ssh/codeberg
```

### Upload key

```
xclip -selection clipboard < ~/.ssh/codeberg.pub
ssh -T git@codeberg.org
```

## Syncthing

```
sudo mkdir -p /etc/apt/keyrings
sudo curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg \
  https://syncthing.net/release-key.gpg

echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] \
https://apt.syncthing.net/ syncthing stable-v2" | \
sudo tee /etc/apt/sources.list.d/syncthing.list

sudo apt update
sudo apt install syncthing
```

## Flatpak and Flathub

```
apt install flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
```

## Mount additional drives

### Identify and prepare

```
lsblk -f
sudo mkdir -p /mnt/nvme
blkid /dev/nvme0n1
```

### Add to `/etc/fstab`

```
UUID=a1b2c3d4-e5f6-7890-abcd-ef1234567890   /mnt/nvme   ext4   defaults   0   2
```

Apply changes:

```
systemctl daemon-reload
mount -a
```

### Set ownership

```
sudo chown -R $USER:$USER /mnt/nvme
sudo chmod 755 /mnt/nvme
ls -ld /mnt/nvme
```

## Steam

Enable 32-bit packages:

```
dpkg --add-architecture i386
apt update
apt install steam-installer
```

### AMD Vulkan

```
apt install mesa-vulkan-drivers libglx-mesa0:i386 \
           mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386
```

### NVIDIA Vulkan

```
apt install nvidia-driver nvidia-driver-libs:i386
```

## Desktop theming

```
apt install adwaita-qt adwaita-icon-theme-full gnome-themes-extra
```
