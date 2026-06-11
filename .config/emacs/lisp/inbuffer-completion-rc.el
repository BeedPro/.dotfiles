;;; inbuffer-completion-rc.el --- In-buffer completion configuration -*- lexical-binding: t; -*-

(use-package corfu
  :custom
  (corfu-preselect 'prompt)
  :init
  (global-corfu-mode))

(use-package cape
  :bind ("C-c p" . cape-prefix-map)
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword))

(provide 'inbuffer-completion-rc)
;;; inbuffer-completion-rc.el ends here
