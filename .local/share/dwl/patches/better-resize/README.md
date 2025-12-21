### Description
This patch allows you to configure window resizing more flexibly.
It introduces three options with the following possible values:

- warp_cursor:
```
   0 - the mouse cursor remains in its original position at the start of the resize.
   1 - the cursor is automatically warped to the selected corner before resizing begins.
```

- lock_cursor:
```
   0 - the cursor can move freely during the resize.
   1 - the cursor position is completely frozen for the entire duration of the resize.
```

- resize_corner:
```
   0: top-left
   1: top-right
   2: bottom-left
   3: bottom-right
   4: selects the corner based on the current mouse quadrant
```

### Demos
All demos below use resize_corner = 4:
| no warp + no lock | warp + lock |
|-|-|
| ![demo-nowarp-nolock](https://github.com/mmistika/dwl-better-resize/blob/main/demo/demo-nowarp-nolock.gif?raw=true) | ![demo-warp-lock](https://github.com/mmistika/dwl-better-resize/blob/main/demo/demo-warp-lock.gif?raw=true) |

| no warp + lock | warp + no lock |
|-|-|
| ![demo-nowarp-lock](https://github.com/mmistika/dwl-better-resize/blob/main/demo/demo-nowarp-lock.gif?raw=true) | ![demo-warp-nolock](https://github.com/mmistika/dwl-better-resize/blob/main/demo/demo-warp-nolock.gif?raw=true) |

### Known Issues (warp + lock)
The combination of warp_cursor and lock_cursor is not recommended without outer gaps.
If the selected resize corner aligns exactly with a screen corner, the cursor gets locked there and cannot be moved outward, so resizing only works inward.
To resize outward, you must restart the resize operation with the cursor positioned somewhere away from the screen corner.
This happens because the locked cursor cannot move past the screen edge, and therefore cannot generate a non-zero delta to resize outward.

On multihead setups, if the resize corner is near another screen, the window may switch monitors upon completion of the resize.

### Download
- [0.7](/dwl/dwl-patches/raw/branch/main/patches/better-resize/better-resize-0.7.patch)

### Authors
- [mmistika](https://codeberg.org/mmistika)
