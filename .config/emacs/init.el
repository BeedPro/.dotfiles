;; -*- lexical-binding: t; -*-

;; Startup Defaults
(setq inhibit-startup-message t
      auto-save-default nil
      make-backup-files nil
      ring-bell-function 'ignore
      set-mark-command-repeat-pop t
      large-file-warning-threshold nil
      vc-follow-symlinks t
      ad-redefinition-action 'accept
      global-auto-revert-non-file-buffers t
      default-input-method "arabic"
      native-comp-async-report-warnings-errors nil)

;; Global modes
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

(load-theme 'modus-vivendi t)

(set-face-attribute 'default nil
                    :family "GohuFont 14 Nerd Font Mono"
                    :height 140)

;; Package management
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

(setq use-package-always-ensure t
      use-package-always-defer t)

;; Editing defaults
(setq-default indent-tabs-mode nil
              tab-width 2
              bidi-paragraph-direction nil
              display-line-numbers-type 'relative)

(global-display-line-numbers-mode 1)

(dolist (mode '(shell-mode-hook
                eshell-mode-hook
                term-mode-hook
                vterm-mode-hook
                treemacs-mode-hook
                minibuffer-setup-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Input method display
(defun beed/arabic-input-method-title ()
  (when (string= current-input-method "arabic")
    (setq current-input-method-title "ARA")))

(add-hook 'input-method-activate-hook #'beed/arabic-input-method-title)
(add-hook 'isearch-mode-hook #'beed/arabic-input-method-title)

;; Custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file t))

;; Packages
(use-package dired
  :ensure nil
  :config
  (setq dired-listing-switches "-alh --group-directories-first")
  (setenv "LC_COLLATE" "C"))

(use-package modus-themes
  :ensure t
  :demand t
  :config
  (setq modus-themes-bold-constructs t
        modus-themes-italic-constructs nil))

(use-package doom-themes
  :defer nil
  :init
  (set-face-attribute 'line-number nil :slant 'normal)
  (set-face-attribute 'line-number-current-line nil :slant 'normal)
  :custom
  (doom-themes-enable-italic nil))

(use-package doom-modeline
  :defer nil
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
  (doom-modeline-def-segment input-method
    (when current-input-method
      (concat
       (doom-modeline-spc)
       (propertize current-input-method-title
                   'face (doom-modeline-face))
       (doom-modeline-spc))))

  (doom-modeline-mode 1))

(use-package magit
  :bind ("C-x g" . magit-status)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package vundo
  :bind ("C-x u" . vundo))

(use-package diff-hl
  :defer nil
  :hook ((prog-mode         . diff-hl-mode)
         (text-mode         . diff-hl-mode)
         (dired-mode        . diff-hl-dired-mode)
         (magit-pre-refresh . diff-hl-magit-pre-refresh)
         (magit-post-refresh . diff-hl-magit-post-refresh))
  :config
  (global-diff-hl-mode 1)
  (unless (display-graphic-p)
    (diff-hl-margin-mode 1))
  (diff-hl-flydiff-mode 1))

(use-package yasnippet
  :defer nil
  :config
  (yas-global-mode 1))

(use-package apheleia
  :bind (("C-c C-f" . apheleia-format-buffer))
  :config
  (setf (alist-get 'prettypst apheleia-formatters)
        '("prettypst" filepath))
  (setf (alist-get 'typst-ts-mode apheleia-mode-alist) '(prettypst)))

(use-package vertico
  :init
  (vertico-mode 1))

(use-package marginalia
  :init
  (marginalia-mode 1))

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package eglot
  :ensure nil
  :hook (typst-ts-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '(typst-ts-mode . ("tinymist"))))

(use-package corfu
  :init
  (global-corfu-mode))

(use-package cape
  :bind ("C-c p" . cape-prefix-map)
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword))

(use-package typst-ts-mode
  :mode ("\\.typ\\'" . typst-ts-mode)
  :init
  (with-eval-after-load 'treesit
    (add-to-list 'treesit-language-source-alist
                 '(typst "https://github.com/uben0/tree-sitter-typst"))))

;; https://github.com/svaante/dape
