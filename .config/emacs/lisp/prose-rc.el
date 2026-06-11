;;; prose-rc.el --- Prose configuration -*- lexical-binding: t; -*-

(use-package tex
  :ensure auctex
  :mode ("\\.tex\\'" . LaTeX-mode)
  :hook ((LaTeX-mode . flyspell-mode)
         (LaTeX-mode . LaTeX-math-mode)
         (LaTeX-mode . turn-on-reftex))
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
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :custom
  (markdown-command "pandoc")
  (markdown-fontify-code-blocks-natively t)
  (markdown-enable-wiki-links t)
  (markdown-italic-underscore t)
  :hook ((markdown-mode . flyspell-mode)
         (gfm-mode . flyspell-mode)))

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

(use-package org
  :ensure nil
  :mode ("\\.org\\'" . org-mode)
  :bind (("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         ("C-c l" . org-store-link))
  :config
  (setq org-directory
        (file-truename
         (expand-file-name "~/Compendium/Journal/")))

  (setq org-agenda-files
        (mapcar (lambda (file)
                  (expand-file-name file org-directory))
                '("capture.org" "wishlist.org")))

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

(provide 'prose-rc)
;;; prose-rc.el ends here
