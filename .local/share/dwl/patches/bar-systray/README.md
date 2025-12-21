### Description
Add a system tray to the [bar](/dwl/dwl-patches/src/branch/main/patches/bar).

To keep dependencies to minimum, icon(svg) loading from the filesystem is not
supported. Applications that expect this will show the initial letter of the
program name, instead of a real icon.

Menus for the icons are handled by a dmenu-like program of the user's choice.

### Dependencies
- [bar.patch](/dwl/dwl-patches/src/branch/main/patches/bar)
- [libdbus](https://gitlab.freedesktop.org/dbus/dbus)

### Download
- [git branch](/janetski/dwl/src/branch/0.7-bar-systray)
- [0.7](/dwl/dwl-patches/raw/branch/main/patches/bar-systray/bar-systray-0.7.patch)

### Authors
- [janetski](https://codeberg.org/janetski) ([.vetu](https://discordapp.com/users/355488216469471242) on discord)
