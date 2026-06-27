;;; snippets-rc.el --- Snippet configuration -*- lexical-binding: t; -*-

(use-package yasnippet
  :defer nil
  :init
  (setq yas-snippet-dirs
        (list (expand-file-name "snippets" beed/emacs-config-directory)))
  :config
  (yas-global-mode 1))

(provide 'snippets-rc)
;;; snippets-rc.el ends here
