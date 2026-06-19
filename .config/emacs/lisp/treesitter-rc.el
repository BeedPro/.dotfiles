;;; treesitter-rc.el --- Tree-sitter configuration -*- lexical-binding: t; -*-

(use-package treesit-auto
  :demand t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package typst-ts-mode
  :mode ("\\.typ\\'" . typst-ts-mode)
  :init
  (with-eval-after-load 'treesit
    (add-to-list 'treesit-language-source-alist
                 '(typst "https://github.com/uben0/tree-sitter-typst"))))

(provide 'treesitter-rc)
;;; treesitter-rc.el ends here
