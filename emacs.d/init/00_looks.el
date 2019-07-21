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
  (eval-after-load "company" '(diminish 'company-mode))
  (eval-after-load "undo-tree" '(diminish 'undo-tree-mode))
  (eval-after-load "ivy" '(diminish 'ivy-mode))
  (eval-after-load "eldoc" '(diminish 'eldoc-mode))
  (eval-after-load "smartparens" '(diminish 'smartparens-mode))
  (eval-after-load "symbol-overlay" '(diminish 'symbol-overlay-mode))
  (eval-after-load "git-gutter" '(diminish 'git-gutter-mode))
  )

;;color
(set-face-foreground 'font-lock-comment-face "MediumSeaGreen")
(set-face-foreground 'font-lock-string-face "lightskyblue")
(set-face-foreground 'font-lock-keyword-face "NavajoWhite")
(set-face-foreground 'font-lock-function-name-face "NavajoWhite")
(set-face-bold-p 'font-lock-function-name-face t)
(set-face-foreground 'font-lock-variable-name-face "lawn green")
(set-face-foreground 'font-lock-type-face "LightSeaGreen")
(set-face-foreground 'font-lock-builtin-face "medium aquamarine")
(set-face-foreground 'font-lock-warning-face "blue")
(set-background-color "Black")
(set-foreground-color "LightGray")
(set-cursor-color "White")
(set-frame-parameter nil 'alpha 90)

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
