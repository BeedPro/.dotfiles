;;; filebrowser-rc.el --- File browser configuration -*- lexical-binding: t; -*-

(use-package dired
  :ensure nil
  :config
  (setq dired-listing-switches "-alh --group-directories-first")
  (setenv "LC_COLLATE" "C"))

(provide 'filebrowser-rc)
;;; filebrowser-rc.el ends here
