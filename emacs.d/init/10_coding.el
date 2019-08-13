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

(use-package point-history
  :straight (:host github
                   :repo "blue0513/point-history"
                   :branch "master"))
