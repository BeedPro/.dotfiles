;;; lsp-rc.el --- LSP configuration -*- lexical-binding: t; -*-

(defun beed/eglot-ensure-if-server (server)
  "Start Eglot when SERVER is available on the current machine."
  (when (executable-find server)
    (eglot-ensure)))

(use-package eglot
  :ensure nil
  :hook ((typst-ts-mode . (lambda () (beed/eglot-ensure-if-server "tinymist")))
         (LaTeX-mode . (lambda () (beed/eglot-ensure-if-server "texlab"))))
  :config
  (when (executable-find "tinymist")
    (add-to-list 'eglot-server-programs '(typst-ts-mode . ("tinymist"))))
  (when (executable-find "texlab")
    (add-to-list 'eglot-server-programs '(LaTeX-mode . ("texlab")))))

(provide 'lsp-rc)
;;; lsp-rc.el ends here
