;; -*- lexical-binding: t; -*-

(defconst beed/emacs-config-directory
  (file-name-directory (or load-file-name buffer-file-name)))

(add-to-list 'load-path (expand-file-name "lisp" beed/emacs-config-directory))

;; Startup defaults
(setq inhibit-startup-message t
      initial-scratch-message nil
      auto-save-default nil
      make-backup-files nil
      ring-bell-function 'ignore
      set-mark-command-repeat-pop t
      large-file-warning-threshold nil
      vc-follow-symlinks t
      ad-redefinition-action 'accept
      global-auto-revert-non-file-buffers t
      bookmark-save-flag 1
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
              tab-width 4
              fill-column 80
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

(add-hook 'before-save-hook #'delete-trailing-whitespace)

;; Input method display
(defun beed/arabic-input-method-title ()
  (when (string= current-input-method "arabic")
    (setq current-input-method-title "ARA")))

(add-hook 'input-method-activate-hook #'beed/arabic-input-method-title)
(add-hook 'isearch-mode-hook #'beed/arabic-input-method-title)

;; Custom file
(setq custom-file (expand-file-name "custom.el" beed/emacs-config-directory))
(when (file-exists-p custom-file)
  (load custom-file t))

;; UI
(require 'config-dashboard)
(require 'config-whitespace)
(require 'config-modus-themes)
(require 'config-doom-themes)
(require 'config-doom-modeline)

;; Files
(require 'config-dired)

;; Editing
(require 'config-yasnippet)
(require 'config-apheleia)
(require 'config-corfu)
(require 'config-cape)

;; Completion
(require 'config-vertico)
(require 'config-marginalia)
(require 'config-orderless)
(require 'config-consult)
(require 'config-embark)
(require 'config-embark-consult)

;; Version control
(require 'config-magit)
(require 'config-vundo)
(require 'config-diff-hl)

;; Programming
(require 'config-treesit-auto)
(require 'config-typst-ts-mode)
(require 'config-eglot)

;; Writing
(require 'config-tex)
(require 'config-reftex)
(require 'config-markdown-mode)

;; Org
(require 'config-org)
