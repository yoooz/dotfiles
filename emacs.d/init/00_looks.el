(use-package doom-themes
  :custom
  (doom-themes-enable-italic t)
  (doom-themes-enable-bold t)
  :config
  (load-theme 'doom-snazzy t)
  ;;(load-theme 'doom-vibrant t)
  )

(use-package hide-mode-line
  :hook
  ((treemacs-mode) . hide-mode-line-mode))

;; smart mode line
(use-package rich-minority)
(use-package smart-mode-line-powerline-theme)
(use-package smart-mode-line
  :config
  (setq sml/no-confirm-load-theme t)
  (defvar sml/theme 'powerline-theme)
  (defvar sml/shorten-directory -1)
  (sml/setup)
  )

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
