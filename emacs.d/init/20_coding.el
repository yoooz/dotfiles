(use-package symbol-overlay
  :diminish symbol-overlay-mode
  :hook ((prog-mode markdown-mode) . symbol-overlay-mode)
  :bind
  (:map symbol-overlay-map
   ("C-g" . symbol-overlay-remove-all)
   ("<escape>" . symbol-overlay-remove-all)
   :map evil-normal-state-map
   ("#" . symbol-overlay-put))
  :custom
  (symbol-overlay-idle-time 0.5))

(use-package highlight-indent-guides
  :diminish highlight-indent-guides-mode
  :hook ((prog-mode yaml-mode) . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-auto-enabled t)
  (highlight-indent-guides-responsive t)
  (highlight-indent-guides-method 'character))

(use-package smartparens
  :diminish smartparens-mode
  :config
  (smartparens-global-mode t))

(use-package magit
  :custom-face
  (magit-diff-added ((t (:foreground "#00FF00" :background "gray20"))))
  (magit-diff-added-highlight ((t (:foreground "#00FF00" :background "gray20"))))
  (magit-diff-removed ((t (:foreground "#FF0000" :background "gray20"))))
  (magit-diff-removed-highlight ((t (:foreground "#FF0000" :background "gray20"))))
  :custom 
  (magit-log-margin '(t "%Y-%m-%d %H:%M:%S" magit-log-margin-width t 18)))

(use-package evil-magit)

(use-package git-gutter
  :diminish git-gutter-mode
  :custom
  (git-gutter:ask-p nil)
  (global-git-gutter-mode t)
  :custom-face
  (git-gutter:modified ((t (:background "#f1fa8c" :foreground "#f1fa8c"))))
  (git-gutter:added    ((t (:background "#50fa7b" :foreground "#50fa7b"))))
  (git-gutter:deleted  ((t (:background "#ff79c6" :foreground "#ff79c6")))))
