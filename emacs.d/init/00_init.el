(use-package evil
  :config
  (setq evil-cross-lines t)
  (setq evil-search-module 'isearch)
  (defalias 'evil-insert-state 'evil-emacs-state)
  (evil-mode 1)
  (setq evil-want-fine-undo t)
  (setq evil-esc-delay 0)
  )

(define-key evil-emacs-state-map (kbd "<escape>") 'evil-normal-state)
(define-key evil-emacs-state-map (kbd "C-g") 'evil-normal-state)
(define-key evil-normal-state-map (kbd "gg") 'goto-line)
;; buffer
(define-key evil-normal-state-map (kbd "b k") 'kill-buffer)
(define-key evil-normal-state-map (kbd "b s") 'switch-to-buffer)
;; window
(define-key evil-normal-state-map (kbd "w o") 'other-window)
(define-key evil-normal-state-map (kbd "w v") 'split-window-below)
(define-key evil-normal-state-map (kbd "w h") 'split-window-right)
