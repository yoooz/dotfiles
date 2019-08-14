(use-package doom-themes
  :custom
  (doom-themes-enable-italic t)
  (doom-themes-enable-bold t)
  :config
  (load-theme 'doom-snazzy t)
  ;;(load-theme 'doom-vibrant t)
  )

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :config
  (setq doom-modeline-height 25)
  (setq doom-modeline-bar-width 3)
  (setq doom-modeline-buffer-file-name-style 'truncate-all)
  )

(use-package hide-mode-line
  :hook
  ((treemacs-mode) . hide-mode-line-mode))

;; diminish
(use-package diminish
  :config
  (diminish 'emacs-lock-mode)
  (diminish 'eldoc-mode)
  )

;; rainbow delimiters
(use-package cl-lib)
(use-package color)
(use-package rainbow-delimiters
  :hook
  ((prog-mode) . rainbow-delimiters-mode)
  )
