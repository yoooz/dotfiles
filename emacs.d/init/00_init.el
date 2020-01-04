(use-package evil
  :config
  (evil-mode t)
  (defalias 'evil-insert-state 'evil-emacs-state)
)

(define-key evil-emacs-state-map (kbd "<escape>") 'evil-normal-state)
