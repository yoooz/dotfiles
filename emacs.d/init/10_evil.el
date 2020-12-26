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
  )

(global-set-key "\C-g" 'evil-normal-state)
;; メインはUSキーボードなので ; と : を入れ替える
(define-key evil-normal-state-map (kbd ";") 'evil-ex)
(define-key evil-normal-state-map (kbd ":") 'evil-repeat-find-char)
(define-key evil-visual-state-map (kbd "C-r") `counsel-M-x)

(use-package key-chord
  :commands (key-chord-mode)
  :init
  (setq key-chord-two-keys-delay 0.5)
  (key-chord-define-global "jj" 'evil-normal-state))

;; key-chordが途中で切れることがあるので、insert-stateに入るたびにONにする
(add-hook 'evil-insert-state-entry-hook (lambda()
                                         (key-chord-mode 1)))
(add-hook 'evil-insert-state-exit-hook (lambda()
                                         (key-chord-mode nil)))

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
        ("gT" . elscreen-previous)
        ("gt" . evil-tabs-goto-tab))
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

(evil-define-motion evil-tabs-goto-tab (&optional count)
  (if count
      (elscreen-goto count)
    (elscreen-next)))

(evil-ex-define-cmd "q[uit]" 'evil-tab-sensitive-quit)
(evil-ex-define-cmd "tabnew" 'elscreen-create)
(evil-ex-define-cmd "tabclone" 'elscreen-clone)
(evil-ex-define-cmd "tabg[o]" 'elscreen-goto)
(evil-ex-define-cmd "tabn[ext]" 'elscreen-next)
(evil-ex-define-cmd "tabp[revious]" 'elscreen-previous)
