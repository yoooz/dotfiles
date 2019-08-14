;; smartrep & multiple-cursors
(use-package multiple-cursors)

;; symbol-overlay
(use-package symbol-overlay
  :diminish symbol-overlay-mode
  :hook
  ((prog-mode markdown-mode) . symbol-overlay-mode)
  :bind
  (("M-i" . symbol-overlay-put)
   :map symbol-overlay-map
   ("p" . symbol-overlay-jump-prev)
   ("n" . symbol-overlay-jump-next)
   ("C-g" . symbol-overlay-remove-all))
  :config
  (custom-set-variables
   '(symbol-overlay-idle-time 0.1))
  )

;; smartparens
(use-package smartparens
  :diminish smartparens-mode
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
