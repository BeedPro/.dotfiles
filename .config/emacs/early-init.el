;; -*- lexical-binding: t; -*-

;; Work around distro site-start files that expect this variable.
(defvar flavor 'emacs)

;; Let the window manager size frames to exact pixels, avoiding unused strips
;; when the frame width is not an exact multiple of the font cell width.
(setq frame-resize-pixelwise t)
