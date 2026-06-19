For partitioning and disk setup during a fresh install, see [`INSTALL.md`](./INSTALL.md).

Remember to update `xbps` and the system packages first:

```bash
sudo xbps-install -Syu xbps
sudo xbps-install -Syu
````

Then install the minimal dependencies:

```bash
sudo xbps-install -S git neovim curl stow
```

Now clone the repository over HTTPS:

```bash
git clone https://github.com/BeedPro/.dotfiles.git
```

After that, use the grouped installers in `.voidlinux/add/` as needed:

- `base`: CLI essentials and editors.
- `desktop`: X11/i3 desktop apps and utilities.
- `media`: MPD, MPV, Zathura, and related media tools.
- `dev`: developer tooling packaged by Void.
- `docs`: LaTeX and Typst tooling packaged by Void.
- `fonts`: font packages replacing the old `getnf` flow.
- `gaming`: Steam and Lutris, with required Void repos enabled.
- `hardware`: HPLIP plus Polychromatic/OpenRazer.
- `networking`: Syncthing and WireGuard tools.
- `virt`: QEMU/libvirt setup.
- `docker`: Docker plus Docker Compose.
- `nvidia`: NVIDIA driver stack from Void repos.
- `flatpak`: Flatpak plus the Flathub remote.
- `flathub`: Flathub applications.

Standalone helpers are also available for `betterfox`, `crontab`, `github`, `mpd-mpris`, `qemu-kvm.guest`, `vial-qmk`, `wallpapers`, and `xfce4`.

Some old Debian `add/` scripts were intentionally not ported because Void does not provide them in its repositories. Those currently include `auto-cpufreq`, `bun`, `deno`, `espanso`, `getnf`, `ghcup`, `helium`, `heroic`, `nix`, `opencode-ai`, and `protonvpn`.

Contributors can switch the remote to SSH later, after installing and configuring XFCE and SSH authentications:

```bash
git remote set-url origin git@github.com:BeedPro/.dotfiles.git
```
