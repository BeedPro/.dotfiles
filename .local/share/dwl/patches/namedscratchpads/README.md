### Description
Allows for the creation of multiple scratchpad windows, each assigned to a different keybinding. In simple terms, it enables 'run or raise' functionality

This patch adds the following functions:

* `togglescratch`: simply toggles the scratchpad window
* `focusortogglescratch`: change the focus to the scratchpad window if it is visible and toggles it if it is already in focus
* `focusortogglematchingscratch`: similar to `focusortogglescratch` but also closes all other scratchpad windows

If you don't assign keybindings to any of the above functions and so get a compiler warning about them not being used, just remove them from your dwl branch to stop the warning.

### Download
- [git branch (v0.6)](https://codeberg.org/bencc/dwl/src/branch/namedscratchpads)
- [2024-07-13 (v0.6)](https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/namedscratchpads/namedscratchpads.patch)

### Authors
- [Ben Collerson](https://codeberg.org/bencc)
- [wochap](https://codeberg.org/wochap)
- [Louis-Michel Raynauld](https://github.com/loumray)
