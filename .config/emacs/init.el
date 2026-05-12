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

(load-theme 'gruber-darker t)

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

(unless package-archive-contents
  (package-refresh-contents))

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
(use-package gruber-darker-theme)
