For partitioning and disk setup during a fresh install, see [`INSTALL.md`](./INSTALL.md).

Remember to update `xbps` and the system packages first:

```bash
sudo xbps-install -u xbps
sudo xbps-install -Syu
````

Then install the minimal dependencies:

```bash
sudo xbps-install -S git neovim
```

Now clone the repository over HTTPS:

```bash
git clone https://github.com/BeedPro/.dotfiles.git
```

Contributors can switch the remote to SSH later, after installing and configuring XFCE and SSH authentications:

```bash
git remote set-url origin git@github.com:BeedPro/.dotfiles.git
```
