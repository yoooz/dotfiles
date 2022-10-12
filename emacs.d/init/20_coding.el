(use-package indent-guide
  :defer t
  :diminish indent-guide-mode
  :hook ((prog-mode) . indent-guide-mode)
  :custom
  (indent-guide-recursive t)
  :custom-face
  (indent-guide-face ((t (:foreground "#b0e0e6" :slant normal)))))

(use-package git-gutter
  :config
  (setq git-gutter:update-hooks '(after-save-hook after-revert-hook))
  (global-git-gutter-mode t)
  :custom
  (git-gutter:modified-sign "=")
  (git-gutter:added-sign "+")
  (git-gutter:deleted-sign "-")
  :custom-face
  (git-gutter:modified ((t (:foreground "#f1fa8c"))))
  (git-gutter:added ((t (:foreground "#50fa7b"))))
  (git-gutter:deleted ((t (:foreground "#ff79c6"))))
  )

(use-package which-key
  :defer
  :straight (which-key :type git :host github :repo "justbur/emacs-which-key")
  :diminish which-key-mode
  :custom
  (which-key-idle-delay 0.5))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))
