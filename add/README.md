# Debian New System Setup

This is a guide on setting up a new debian system, as of writing this is for
Debian Trixie and so all examples are in that version.

## Configure APT sources

### Update system and install initial applications

```bash
sudo apt update
sudo apt upgrade
sudo apt install git git-lfs xclip vim zsh
```

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

```bash
sudo apt modernize-sources
sudo rm -rf /etc/apt/sources.list.bak
sudo rm -rf /etc/apt/sources.list.d/*.bak
sudo apt update
```

## Codeberg SSH setup

This is to setup git remotes via the ssh protocol, for this section it should
work with all git remotes but this one is for `codeberg.org`.

### Create key

```bash
cd ~/.ssh
ssh-keygen -t ed25519 -a 100 -f codeberg
ssh-add codeberg
```

### SSH config

Add to `~/.ssh/config`:

```bash
Host codeberg.org
  HostName codeberg.org
  User git
  IdentityFile ~/.ssh/codeberg
```

### Upload key

```bash
xclip -selection clipboard < ~/.ssh/codeberg.pub
```

Add the key to your Codeberg account. and verify it worked via:

```bash
ssh -T git@codeberg.org
```

## Mount additional drives

### Identify and prepare

```bash
sudo lsblk -f
sudo mkdir -p /mnt/nvme
sudo chown -R $USER:$USER /mnt/nvme
sudo chmod 755 /mnt/nvme
ls -ld /mnt/nvme
sudo blkid /dev/nvme0n1
```

### Add to `/etc/fstab`

```bash
UUID=a1b2c3d4-e5f6-7890-abcd-ef1234567890   /mnt/nvme   ext4   defaults   0   2
```

Apply changes:

```
sudo systemctl daemon-reload
sudo mount -a
```

## Setup crontab

The one I use is to update my org calendars using `crontab -e`:

```
@hourly $HOME/Compndium/Agenda/.sync/calendars.sh >$HOME/.local/share/org-gcal/sync.log 2>&1
```

## GRUB configuration

If you are dual booting Windows and you installed Debian after installing
Windows you may want the boot loader to be on the GRUB screen.

Edit `/etc/default/grub`:

```bash
GRUB_DISABLE_OS_PROBER=false
```

Then regenerate GRUB with `sudo update-grub`.

## Zsh as default shell

```bash
chsh -s /usr/bin/zsh
```

Make sure to reboot when prompted, if you did not reboot yet this is now the time to do so.
