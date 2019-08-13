(use-package doom-themes
  :custom
  (doom-themes-enable-italic t)
  (doom-themes-enable-bold t)
  :config
  (load-theme 'doom-snazzy t)
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
  (custom-set-faces
   '(sml/folder ((t (:inherit sml/global :background "grey17" :foreground "gray90" :weight normal)))))
  (sml/setup)
  )

;; diminish
(use-package diminish
  :config
  (eval-after-load "company" '(diminish 'company-mode))
  (eval-after-load "undo-tree" '(diminish 'undo-tree-mode))
  (eval-after-load "ivy" '(diminish 'ivy-mode))
  (eval-after-load "eldoc" '(diminish 'eldoc-mode))
  (eval-after-load "smartparens" '(diminish 'smartparens-mode))
  (eval-after-load "symbol-overlay" '(diminish 'symbol-overlay-mode))
  (eval-after-load "git-gutter" '(diminish 'git-gutter-mode))
  (eval-after-load "ivy-posframe" '(diminish 'ivy-posframe-mode))
  )

;; rainbow delimiters
(use-package cl-lib)
(use-package color)
(use-package rainbow-delimiters
  :config
  (rainbow-delimiters-mode 1)
  (setq rainbow-delimiters-outermost-only-face-count 1)
  (set-face-foreground 'rainbow-delimiters-depth-1-face "#f0f0f0")
  (set-face-foreground 'rainbow-delimiters-depth-2-face "#ff5e5e")
  (set-face-foreground 'rainbow-delimiters-depth-3-face "#ffaa77")
  (set-face-foreground 'rainbow-delimiters-depth-4-face "#dddd77")
  (set-face-foreground 'rainbow-delimiters-depth-5-face "#80ee80")
  (set-face-foreground 'rainbow-delimiters-depth-6-face "#66bbff")
  (set-face-foreground 'rainbow-delimiters-depth-7-face "#da6bda")
  (set-face-foreground 'rainbow-delimiters-depth-8-face "#afafaf")
  (set-face-foreground 'rainbow-delimiters-depth-9-face "#9a4040")
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  )
