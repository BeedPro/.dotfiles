;;; lsp-treesitter-rc.el --- LSP and tree-sitter configuration -*- lexical-binding: t; -*-

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

(use-package eglot
  :ensure nil
  :hook ((typst-ts-mode . eglot-ensure)
         (LaTeX-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs '(typst-ts-mode . ("tinymist")))
  (add-to-list 'eglot-server-programs '(LaTeX-mode . ("texlab"))))

(provide 'lsp-treesitter-rc)
;;; lsp-treesitter-rc.el ends here
