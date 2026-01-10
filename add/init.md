# Apt
apt modernize-sources
rm -rf /etc/apt/sources.list.bak
rm -rf /etc/apt/sources.list.d/*.bak
apt install vim git curl git-lfs stow eza zsh
apt build-dep dwm

```/etc/apt/sources.list
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
```/etc/apt/sources.list.d/debian-backports.sources
Types: deb deb-src
URIs: http://deb.debian.org/debian
Suites: trixie-backports
Components: main
Enabled: yes
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
```

# bat
apt install bat
ln -sf /usr/bin/batcat /usr/local/bin/bat

# Multimedia codex
apt-get install libavcodec-extra

# Nvidia
apt install linux-headers-generic
apt install nvidia-detect
apt install nvidia-open-kernel-dkms nvidia-driver

# grub
sudo vim /etc/default/grub
GRUB_DISABLE_OS_PROBER=false

# zsh
chsh -s /usr/bin/zsh


# dwm
sudo apt install libfribidi-dev

# st
sudo apt install libimlib2-dev
sudo apt install libgd-dev


# Codeberg
cd .ssh
ssh-keygen -t ed25519 -a 100
ssh-add codeberg
```config
Host codeberg.org
  HostName codeberg.org
  User git
  IdentityFile ~/.ssh/codeberg
```
xclip -selection clipboard < ~/.ssh/codeberg.pub
ssh -T git@codeberg.org
# Syncthing
sudo mkdir -p /etc/apt/keyrings
sudo curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg

echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable-v2" | sudo tee /etc/apt/sources.list.d/syncthing.list

sudo apt-get update
sudo apt-get install syncthing

# Flatpaks
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo



# Drives

lsblk -f
sudo mkdir -p /mnt/nvme
blkid /dev/nvme0n1
```/etc/fstab
UUID=a1b2c3d4-e5f6-7890-abcd-ef1234567890   /mnt/nvme   ext4   defaults   0   2
```
systemctl daemon-reload

sudo chown -R beed:beed /mnt/nvme
sudo chmod 755 /mnt/nvme
ls -ld /mnt/nvme

# Steam
dpkg --add-architecture i386
apt update
sudo apt install steam-installer
## AMD
apt install mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386
## NVIDIA
apt install nvidia-driver nvidia-driver-libs:i386

# Theme
sudo apt install adwaita-qt adwaita-icon-theme-full gnome-themes-extra
