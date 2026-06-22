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

Please install XFCE4 now using `add/xfce4`. After rebooting, please set up
GitHub SSH using `add/github`. The `add/github` script will wait while you add
the SSH key to the GitHub portal in Firefox. Once you’ve done that, return to
the script and finish it; it should update the origin to the SSH endpoint.

Once GitHub has been set up and the repository origin has been updated to use
SSH, please change into the dotfiles directory with `cd ~/.dotfiles` and run
`stow .` to apply the dotfile symlinks. And run `add/utils` to setup the system
for general use.

For monitors please setup an xorg monitor config.

For laptop for suspends please disable `acpid` service:

```bash
sudo rm /var/service/acpid
```
