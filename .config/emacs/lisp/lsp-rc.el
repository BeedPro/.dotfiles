;;; lsp-rc.el --- LSP configuration -*- lexical-binding: t; -*-

(use-package eglot
  :ensure nil
  :hook ((typst-ts-mode . eglot-ensure)
         (LaTeX-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs '(typst-ts-mode . ("tinymist")))
  (add-to-list 'eglot-server-programs '(LaTeX-mode . ("texlab"))))

(provide 'lsp-rc)
;;; lsp-rc.el ends here
