;;; journal-rc.el --- Journal configuration -*- lexical-binding: t; -*-

(defconst beed/journal-capture-file
  (expand-file-name "~/Compendium/Journal/capture.org"))

(defun beed/org-journal-capture-target ()
  "Capture under today's heading in `beed/journal-capture-file'."
  (set-buffer (org-capture-target-buffer beed/journal-capture-file))
  (widen)
  (let ((heading (format "* %s" (format-time-string "%Y%m%d"))))
    (goto-char (point-max))
    (if (re-search-backward (format "^%s$" (regexp-quote heading)) nil t)
        (progn
          (beginning-of-line)
          (org-end-of-subtree t t)
          (unless (bolp)
            (insert "\n")))
      (goto-char (point-max))
      (unless (bolp)
        (insert "\n"))
      (insert heading "\n"))
    (org-capture-put :exact-position (point) :insert-here t)
    (point)))

(use-package org
  :ensure nil
  :after org
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

  (setq org-capture-templates
        '(("t" "Task" entry
           (function beed/org-journal-capture-target)
           "** TODO %<%H%M%S> - %?")
          ("n" "Note" entry
           (function beed/org-journal-capture-target)
           "** %<%H%M%S> - %?")))

  (setq org-refile-targets '((org-agenda-files :maxlevel . 2))
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil
        org-agenda-window-setup 'current-window
        org-agenda-start-with-log-mode t))

(provide 'journal-rc)
;;; journal-rc.el ends here
