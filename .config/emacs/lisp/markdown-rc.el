;;; markdown-rc.el --- Markdown configuration -*- lexical-binding: t; -*-

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

(provide 'markdown-rc)
;;; markdown-rc.el ends here
