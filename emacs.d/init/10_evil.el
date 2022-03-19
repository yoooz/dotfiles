(use-package undo-tree
  :config
  (global-undo-tree-mode t))

(use-package evil
  :custom
  (evil-disable-insert-state-bindings t)
  :config
  (setq evil-cross-lines t)
  (setq evil-search-module 'isearch)
  (evil-mode 1)
  (setq evil-want-fine-undo t)
  (setq evil-esc-delay 0)
  (setq evil-insert-state-cursor (let ((color (doom-color 'red))) (list color 'bar)))
  (setq evil-normal-state-cursor (let ((color (doom-color 'green))) (list color 'box)))
  (evil-set-undo-system 'undo-tree)
  :custom
  (evil-split-window-below t)
  (evil-vsplit-window-right t)
  )

(global-set-key "\C-g" 'evil-normal-state)
(define-key evil-visual-state-map (kbd "C-r") `counsel-M-x)
(define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)

(use-package key-chord
  :commands (key-chord-mode)
  :init
  (key-chord-mode 1)
  (setq key-chord-two-keys-delay 0.5)
  (key-chord-define evil-insert-state-map "jj" 'evil-normal-state))

(use-package evil-goggles
  :straight (evil-goggles :type git :host github :repo "edkolev/evil-goggles")
  :ensure t
  :config
  (evil-goggles-mode))

(use-package elscreen
  :config
  (elscreen-start)
  :custom
  (elscreen-tab-display-kill-screen nil)
  :custom-face
  (elscreen-tab-current-screen-face ((t (:background "#57c7ff" :foreground "white"))))
  (elscreen-tab-other-screen-face ((t (:background "#282a36" :foreground "white"))))
  :bind
  (:map evil-normal-state-map
        ("gt" . elscreen-next)
        ("gT" . elscreen-previous))
  )

(use-package elscreen-tab
  :config
  (elscreen-tab-mode)
  (elscreen-tab-set-position 'top))

(evil-define-command evil-tab-sensitive-quit (&optional bang)
  :repeat nil
  (interactive "<!>")
  (if (> (length (elscreen-get-screen-list)) 1)
    (elscreen-kill)
    (evil-quit bang)))

(evil-ex-define-cmd "q[uit]" 'evil-tab-sensitive-quit)
(evil-ex-define-cmd "tabnew" 'elscreen-create)
(evil-ex-define-cmd "tabclone" 'elscreen-clone)
(evil-ex-define-cmd "tabg[o]" 'elscreen-goto)
(evil-ex-define-cmd "tabn[ext]" 'elscreen-next)
(evil-ex-define-cmd "tabp[revious]" 'elscreen-previous)
