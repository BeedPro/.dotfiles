### Description

implements wlr-tablet-v2 for drawing tablets and supports cursor emulation

inspired by @guyuming76's [branch](https://codeberg.org/guyuming76/dwl/commits/branch/graphic_tablet), with coding help from @Palanix and testing by @Thanatos

**Please note:** wlroots modified the order of arguments to the function `wlr_surface_accepts_tablet_v2`  
In versions less than or equal to 0.18.1 (against which, dwl 0.7 is typically built), the order is `tablet, surface`.  
In the master branch and (anticipated) in versions later than 0.18.1, the order is `surface, tablet`.  
The git branch for this patch uses the `surface, tablet` order.

If you are attempting to use this codebase to make your own modifications to the patch, there is only one call to the `wlr_surface_accepts_tablet_v2` function, but you will need to make the argument order change if you expect to build against wlroots 0.18.1 or earlier.

The `0.7` patch linked here accounts for the change and uses the `tablet, surface` order, but the patch is orphaned from a codebase.

There was discussion of this matter in [Issue #141](https://codeberg.org/dwl/dwl-patches/issues/141).

### Download

- [git branch](https://codeberg.org/fauxmight/dwl/src/branch/tablet-input)
- [main 2025-05-18](https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/tablet-input/tablet-input.patch)
- [0.7](https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/tablet-input/tablet-input-0.7.patch)

### Authors

- [fauxmight](https://codeberg.org/fauxmight)
- [notchoc](https://codeberg.org/notchoc)
- [Palanix](https://codeberg.org/Palanix)
