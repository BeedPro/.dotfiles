;;; ui-rc.el --- UI configuration -*- lexical-binding: t; -*-

(set-face-attribute 'default nil
                    :family "IosevkaTerm Nerd Font"
                    :height 160)

(set-fontset-font t 'arabic
                  (font-spec :family "Noto Sans Arabic"))

(set-face-attribute 'variable-pitch nil
                    :family "IosevkaTerm Nerd Font"
                    :height 160)

(use-package whitespace
  :ensure nil
  :defer nil
  :custom
  (whitespace-style '(face trailing tabs tab-mark nbsp nbsp-mark))
  (whitespace-display-mappings
   '((tab-mark 9 [?> ?\s ?\s ?\s] [?> ?\s ?\s ?\s])
     (nbsp-mark 160 [?+] [?+])))
  :config
  (global-whitespace-mode 1))

(use-package modus-themes
  :demand t
  :config
  (setq modus-themes-bold-constructs t
         modus-themes-italic-constructs nil)
  (set-face-attribute 'line-number nil :slant 'normal)
  (set-face-attribute 'line-number-current-line nil :slant 'normal)
  (load-theme 'modus-vivendi t))

(use-package doom-modeline
  :defer nil
  :init
  (setq doom-modeline-icon nil
        doom-modeline-major-mode-icon nil
        doom-modeline-major-mode-color-icon nil
        doom-modeline-buffer-state-icon nil
        doom-modeline-buffer-modification-icon nil
        doom-modeline-lsp-icon nil
        doom-modeline-time-icon nil
        doom-modeline-time-live-icon nil
        doom-modeline-time-analogue-clock nil
        doom-modeline-vcs-icon nil
        doom-modeline-check-icon nil
        doom-modeline-persp-icon nil
        doom-modeline-modal-icon nil
         doom-modeline-modal-modern-icon nil
         doom-modeline-unicode-fallback nil
         doom-modeline-unicode-number nil)
  :config
  (doom-modeline-mode 1))

(provide 'ui-rc)
;;; ui-rc.el ends here
