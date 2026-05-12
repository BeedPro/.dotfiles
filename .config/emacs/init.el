;; -*- lexical-binding: t; -*-
(setq inhibit-startup-message t
      auto-save-default nil
      make-backup-files nil
      set-mark-command-repeat-pop t
      large-file-warning-threshold nil
      vc-follow-symlinks t
      ad-redefinition-action 'accept
      global-auto-revert-non-file-buffers t
      native-comp-async-report-warnings-errors nil)

(load-theme 'doom-material-dark t)

(repeat-mode 1)
(blink-cursor-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(savehist-mode 1)
(scroll-bar-mode 0)
(xterm-mouse-mode 1)
(display-time-mode 1)
(column-number-mode 1)
(tab-bar-history-mode 1)
(auto-save-visited-mode 1)
(global-visual-line-mode 1)
(global-auto-revert-mode 1)

(require 'package)

(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (user-error "use-package is not installed. Run M-x package-install RET use-package RET"))

;; Run M-x package-refresh-contents manually when needed.
(require 'use-package)

(setq use-package-always-ensure t)

(setq-default indent-tabs-mode nil
              tab-width 2
              display-line-numbers-type 'relative)

(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file t))

;; Packages can be defered using :defer
(use-package doom-themes)
(use-package doom-modeline
  :init
  (setq doom-modeline-icon nil
        doom-modeline-major-mode-icon nil
        doom-modeline-major-mode-color-icon nil
        doom-modeline-buffer-state-icon nil
        doom-modeline-buffer-modification-icon nil
        doom-modeline-lsp-icon nil
        doom-modeline-time-icon nil
        doom-modeline-time-live-icon nil
        doom-modeline-time-analogue-clock nil
        doom-modeline-vcs-icon nil
        doom-modeline-check-icon nil
        doom-modeline-persp-icon nil
        doom-modeline-modal-icon nil
        doom-modeline-modal-modern-icon nil
        doom-modeline-unicode-fallback nil
        doom-modeline-unicode-number nil)
  :config
  (doom-modeline-mode 1))
