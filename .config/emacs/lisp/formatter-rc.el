;;; formatter-rc.el --- Formatter configuration -*- lexical-binding: t; -*-

(use-package apheleia
  :bind (("C-c f" . apheleia-format-buffer))
  :config
  (setf (alist-get 'prettypst apheleia-formatters)
        '("prettypst" "--use-std-in" "--use-std-out"))
  (setf (alist-get 'tex-fmt apheleia-formatters)
        '("tex-fmt" "--stdin" "--tabsize" (number-to-string tab-width)))
  (setf (alist-get 'expand-tab-width apheleia-formatters)
        '("expand" "-t" (number-to-string tab-width)))
  (setf (alist-get 'typst-ts-mode apheleia-mode-alist) '(prettypst))
  (setf (alist-get 'LaTeX-mode apheleia-mode-alist) '(tex-fmt expand-tab-width)))

(provide 'formatter-rc)
;;; formatter-rc.el ends here
