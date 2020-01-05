;; smartrep & multiple-cursors
(use-package multiple-cursors)

;; symbol-overlay
(use-package symbol-overlay
  :diminish symbol-overlay-mode
  :hook ((prog-mode markdown-mode) . symbol-overlay-mode)
  :bind
  (:map evil-normal-state-map
   ("C-i" . symbol-overlay-put)
   :map symbol-overlay-map
   ("p" . symbol-overlay-jump-prev)
   ("n" . symbol-overlay-jump-next)
   ("C-g" . symbol-overlay-remove-all)
   )
  :custom
  (symbol-overlay-idle-time 0.1)
  )

;; highlight-indent-guides
(use-package highlight-indent-guides
  :diminish highlight-indent-guides-mode
  :hook ((prog-mode yaml-mode) . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-auto-enabled t)
  (highlight-indent-guides-responsive t)
  (highlight-indent-guides-method 'character)
)

;; smartparens
(use-package smartparens
  :diminish smartparens-mode
  :config
  (smartparens-global-mode t)
  )

;; color magit
(use-package magit
  :custom-face
  (magit-diff-added ((t (:foreground "#00FF00" :background "gray20"))))
  (magit-diff-added-highlight ((t (:foreground "#00FF00" :background "gray20"))))
  (magit-diff-removed ((t (:foreground "#FF0000" :background "gray20"))))
  (magit-diff-removed-highlight ((t (:foreground "#FF0000" :background "gray20"))))
  :custom 
  (magit-log-margin '(t "%Y-%m-%d %H:%M:%S" magit-log-margin-width t 18))
  :bind
  (:map evil-normal-state-map
        ("SPC g" . magit-status)
        )
)

;; git-gutter
(use-package git-gutter
  :diminish git-gutter-mode
  :custom
  (git-gutter:ask-p nil)
  (global-git-gutter-mode t)
  :custom-face
  (git-gutter:modified ((t (:background "#f1fa8c" :foreground "#f1fa8c"))))
  (git-gutter:added    ((t (:background "#50fa7b" :foreground "#50fa7b"))))
  (git-gutter:deleted  ((t (:background "#ff79c6" :foreground "#ff79c6"))))
)

(use-package point-history
  :straight (:host github
                   :repo "blue0513/point-history"
                   :branch "master"))
