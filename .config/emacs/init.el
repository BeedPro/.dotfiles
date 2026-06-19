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

(when (display-graphic-p)
  (let ((font-spec (font-spec :family "GohuFont 14 Nerd Font Mono")))
    (when (find-font font-spec)
      (set-face-attribute 'default nil
                          :family "GohuFont 14 Nerd Font Mono"
                          :height 140))))

;; Package management
(require 'package)

(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  ;; Bootstrap use-package on first run so a clean machine can start.
  (unless package-archive-contents
    (package-refresh-contents))
  (package-install 'use-package))

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

(use-package dired
  :ensure nil
  :config
  (setq dired-listing-switches "-alh --group-directories-first")
  (setenv "LC_COLLATE" "C"))

(use-package yasnippet
  :defer nil
  :init
  (setq yas-snippet-dirs
        (list (expand-file-name "snippets" beed/emacs-config-directory)))
  :config
  (yas-global-mode 1))

(require 'ui-rc)
(require 'formatter-rc)
(require 'inbuffer-completion-rc)
(require 'completion-rc)
(require 'git-rc)
(require 'treesitter-rc)
(require 'lsp-rc)
(require 'prose-rc)
