;; -*- lexical-binding: t; -*-

;; Startup Defaults
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
(use-package dashboard
  :defer nil
  :config
  (setq initial-buffer-choice 'dashboard-open
        dashboard-startup-banner 'logo-braille
        dashboard-center-content t
        dashboard-vertically-center-content t
        dashboard-items '((recents   . 5)
                          (bookmarks . 5)
                          (projects  . 5)))
  (dashboard-setup-startup-hook))

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
  (setf (alist-get 'tex-fmt apheleia-formatters)
        '("tex-fmt" filepath))
  (setf (alist-get 'typst-ts-mode apheleia-mode-alist) '(prettypst))
  (setf (alist-get 'latex-mode apheleia-mode-alist) '(tex-fmt)))

(use-package vertico
  :init
  (vertico-mode 1))

(use-package marginalia
  :init
  (marginalia-mode 1))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides
   '((file (styles basic partial-completion)))))

(use-package consult
  :bind
  (("C-s"   . consult-line)
   ("C-x b" . consult-buffer)
   ("M-y"   . consult-yank-pop)
   ("M-g g" . consult-goto-line)
   ("M-g i" . consult-imenu)
   ("C-c r" . consult-ripgrep)))

(use-package embark
  :bind
  (("C-."   . embark-act)
   ("C-;"   . embark-dwim)
   ("C-h B" . embark-bindings)))

(use-package embark-consult
  :after (embark consult)
  :demand t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package eglot
  :ensure nil
  :hook ((typst-ts-mode . eglot-ensure)
         (LaTeX-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs
               '(typst-ts-mode . ("tinymist")))
  (add-to-list 'eglot-server-programs
               '(LaTeX-mode . ("texlab"))))

;; https://github.com/svaante/dape

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

(use-package tex
  :ensure auctex
  :mode ("\\.tex\\'" . LaTeX-mode)
  :hook
  ((LaTeX-mode . flyspell-mode)
   (LaTeX-mode . LaTeX-math-mode)
   (LaTeX-mode . turn-on-reftex)
   (LaTeX-mode . (lambda ()
                   (local-set-key (kbd "C-c C-f") #'apheleia-format-buffer))))
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-save-query nil)
  (TeX-PDF-mode t)
  (TeX-source-correlate-mode t)
  (TeX-source-correlate-start-server t)
  :config
  (add-to-list 'TeX-command-list
               '("LatexMk"
                 "latexmk -pdf -interaction=nonstopmode -synctex=1 %s"
                 TeX-run-TeX nil t
                 :help "Run LatexMk"))
  (setq TeX-command-default "LatexMk"))

(use-package reftex
  :ensure nil
  :hook (LaTeX-mode . reftex-mode)
  :custom
  (reftex-plug-into-AUCTeX t))

(use-package markdown-mode
  :mode
  (("README\\.md\\'" . gfm-mode)
   ("\\.md\\'"       . markdown-mode)
   ("\\.markdown\\'" . markdown-mode))
  :custom
  (markdown-command "pandoc")
  (markdown-fontify-code-blocks-natively t)
  (markdown-enable-wiki-links t)
  (markdown-italic-underscore t)
  :hook
  ((markdown-mode . flyspell-mode)
   (gfm-mode      . flyspell-mode)))

(use-package org
  :ensure nil
  :mode ("\\.org\\'" . org-mode)
  :bind
  (("C-c a" . org-agenda)
   ("C-c c" . org-capture)
   ("C-c l" . org-store-link))
  :config
  (setq org-directory
        (file-truename
         (expand-file-name "~/Compendium/Journal/")))

  (setq org-agenda-files
        (mapcar (lambda (file)
                  (expand-file-name file org-directory))
                '("capture.org" "compass.org" "archive.org")))

  (setq org-default-notes-file
        (expand-file-name "capture.org" org-directory))

  (setq org-ellipsis "..."
        org-startup-folded 'content
        org-startup-indented t
        org-hide-leading-stars t
        org-adapt-indentation nil
        org-return-follows-link t
        org-log-done 'time
        org-log-into-drawer t
        org-use-speed-commands t
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 0)

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|"
                    "DONE(d)" "CANCELLED(c)")))

  (defconst beed/journal-capture-file
    (expand-file-name "~/Compendium/Journal/capture.org"))

  (defun beed/org-journal-capture-target ()
    "Capture under today's heading in `beed/journal-capture-file'."
    (set-buffer (org-capture-target-buffer beed/journal-capture-file))
    (org-with-wide-buffer
     (goto-char (point-min))
     (let ((heading (format "* %s" (format-time-string "%Y%m%d"))))
       (unless (re-search-forward (format "^%s$" (regexp-quote heading)) nil t)
         (goto-char (point-min))
         (insert heading "\n"))
       (beginning-of-line))))

  (setq org-capture-templates
        '(("t" "Task" entry
           (function beed/org-journal-capture-target)
           "** TODO %<%H%M%S> - %?\n"
           :prepend t)

          ("n" "Note" entry
           (function beed/org-journal-capture-target)
           "** %<%H%M%S> - %?\n"
           :prepend t)))

  (setq org-refile-targets '((org-agenda-files :maxlevel . 2))
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil
        org-agenda-window-setup 'current-window
        org-agenda-start-with-log-mode t))
