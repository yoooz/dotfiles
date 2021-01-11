(use-package google-this)

(use-package avy
  :custom
  (avy-background t)
  (avy-all-windows t)
  :custom-face
  (avy-lead-face ((t (:foreground "red" :background "#282a36"))))
  (avy-lead-face-0 ((t (:foreground "green" :background "#282a36"))))
  (avy-lead-face-1 ((t (:foreground "yellow" :background "#282a36"))))
  (avy-lead-face-2 ((t (:foreground "blue" :background "#282a36")))))

(use-package ace-window
  :custom
  (aw-keys '(?j ?k ?l ?i ?o ?h ?y ?u ?p))
  (aw-dispatch-always t)
  :custom-face
  (aw-leading-char-face ((t (:height 4.0 :foreground "#f1fa8c")))))

(use-package ivy
  :diminish ivy-mode
  :config
  (ivy-mode 1)
  (setq enable-recursive-minibuffers t)
  (setq ivy-re-builders-alist
        '((t . ivy--regex-plus)))
  :custom
  (swiper-include-line-number-in-search t)
  (ivy-use-virtual-buffers nil)
  (ivy-height 20)
  (ivy-count-format "(%d/%d)")
  (ivy-extra-directories nil)
  (ivy-format-functions-alist '((t . ivy-format-function-arrow)))
  (ivy-initial-inputs-alist '((counsel-M-x . "")))
  :bind
  (("C-s" . swiper)))

(use-package counsel
  :bind
  (("C-r" . counsel-M-x)
   ("C-x C-f" . counsel-find-file)))

(use-package counsel-ghq
  :straight (counsel-ghq :type git :host github :repo "yoooz/counsel-ghq")
  :config
  (ivy-set-actions 'counsel-ghq
                   '(("g" counsel-git "Open Git")
                     ("o" find-file "Open File")
                     ("m" counsel-ghq--open-magit "Open Maigt"))))

;(use-package ivy-posframe
  ;:diminish ivy-posframe-mode
  ;:custom-face
  ;(ivy-posframe-border ((t (:background "CornflowerBlue"))))
  ;(ivy-posframe ((t (:background "#232533"))))
  ;:custom
  ;(ivy-posframe-display-functions-alist
   ;'((swiper . ivy-posframe-display-at-window-bottom-left)
     ;(counsel-rg . ivy-posframe-display-at-frame-bottom-window-center)
     ;(t . ivy-posframe-display-at-frame-top-center)
     ;))
  ;(ivy-posframe-mode 1)
  ;(ivy-posframe-parameters
   ;'((left-fringe . 8)
     ;(right-fringe . 8))))

(use-package all-the-icons-ivy
  :config
  (all-the-icons-ivy-setup))

(use-package all-the-icons-ivy-rich
  :init (all-the-icons-ivy-rich-mode t))

(use-package ivy-rich
  :config
  (ivy-rich-mode t))

(use-package migemo
  :custom
  (migemo-command "cmigemo")
  (migemo-options '("-q" "--emacs"))
  ;; Set your installed path
  (migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  (migemo-user-dictionary nil)
  (migemo-regex-dictionary nil)
  (migemo-coding-system 'utf-8-unix)
  :config
  (migemo-init))

(use-package avy-migemo
  :config
  (avy-migemo-mode t)
  :bind
  (:map evil-normal-state-map
        ("C-;" . avy-migemo-goto-char-timer)))

(use-package beacon
  :diminish beacon-mode
  :config
  (beacon-mode t)
  :custom
  (beacon-size 30)
  (beacon-color 0.2)
  (beacon-blink-delay 0.1)
  (beacon-blink-when-focused t)
  :bind
  (:map evil-normal-state-map
        ("ga" . beacon-blink)))

(use-package zoom
  :diminish zoom-mode
  :custom
  (zoom-size '(0.618 . 0.618)))

(use-package hungry-delete
  :diminish hungry-delete-mode
  :hook (prog-mode . hungry-delete-mode)
  :config
  (setq hungry-delete-chars-to-skip " \t\r\f\v"))

(use-package sudo-edit)

(use-package treemacs)
