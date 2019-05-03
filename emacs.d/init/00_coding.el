;; smartrep & multiple-cursors
(use-package multiple-cursors)

;; symbol-overlay
(use-package symbol-overlay
  :config
  (add-hook 'prog-mode-hook #'symbol-overlay-mode)
  (add-hook 'markdown-mode-hook #'symbol-overlay-mode)
  (global-set-key (kbd "M-i") 'symbol-overlay-put)
  (define-key symbol-overlay-map (kbd "p") 'symbol-overlay-jump-prev)
  (define-key symbol-overlay-map (kbd "n") 'symbol-overlay-jump-next)
  (define-key symbol-overlay-map (kbd "C-g") 'symbol-overlay-remove-all)
  )

;; smartparens
(use-package smartparens
  :config
  (smartparens-global-mode t)
  )

;; dumb-jump
(use-package dumb-jump
  :config
  (setq dumb-jump-mode t)
  (setq dumb-jump-selector 'ivy)
  (setq dumb-jump-use-visible-window nil)
  )

;; company
(use-package company
  :config
  (global-company-mode)
  (setq company-transformers '(company-sort-by-backend-importance))
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-lengh 2)
  (setq company-selection-wrap-around t)
  (setq completion-ignore-case t)
  (setq company-dabbrev-downcase nil)
  (global-set-key (kbd "C-M-i") 'company-complete)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-search-map (kbd "C-n") 'company-select-next)
  (define-key company-search-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "C-s") 'company-filter-candidates)
  (define-key company-active-map (kbd "C-i") 'company-complete-selection)
  (define-key company-active-map [tab] 'company-complete-selection)
  (define-key company-active-map (kbd "C-f") 'company-complete-selection)
  (define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)
  )

;; color magit
(use-package magit
  :config
  (set-face-foreground 'magit-diff-added "#00FF00")
  (set-face-background 'magit-diff-added "#000000")
  (set-face-foreground 'magit-diff-added-highlight "#00FF00")
  (set-face-background 'magit-diff-added-highlight "#gray20")
  
  (set-face-foreground 'magit-diff-removed "#FF0000")
  (set-face-background 'magit-diff-removed "#000000")
  (set-face-foreground 'magit-diff-removed-highlight "#FF0000")
  (set-face-background 'magit-diff-removed-highlight "gray20")
  (custom-set-variables
   '(magit-log-margin '(t "%Y-%m-%d %H:%M:%S" magit-log-margin-width t 18)))
)

;; git-gutter
(use-package git-gutter
  :custom
  (git-gutter:ask-p nil)
  (global-git-gutter-mode t))

