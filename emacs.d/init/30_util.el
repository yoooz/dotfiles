;; tramp
(use-package tramp
  :custom
  (tramp-default-method "ssh")
  )

;; google-this
(use-package google-this)

;; avy
(use-package avy
  :config
  (setq avy-background t)
  :custom-face
  (avy-lead-face ((t (:foreground "red" :background "#282a36"))))
  (avy-lead-face-0 ((t (:foreground "green" :background "#282a36"))))
  (avy-lead-face-1 ((t (:foreground "yellow" :background "#282a36"))))
  (avy-lead-face-2 ((t (:foreground "blue" :background "#282a36"))))
  :bind
  (
   ("C-;" . avy-goto-char-timer))
  )

;; ace-window
(use-package ace-window
  :custom
  (aw-keys '(?j ?k ?l ?i ?o ?h ?y ?u ?p))
  :custom-face
  (aw-leading-char-face ((t (:height 4.0 :foreground "#f1fa8c"))))
)

;; ivy
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
  ("C-s" . swiper)
  )

;; counsel
(use-package counsel
  :bind
  (("C-r" . counsel-M-x)
   ("C-x C-f" . counsel-find-file))
  )

;; counsel-ghq
(use-package counsel-ghq
  :straight (counsel-ghq :type git :host github :repo "SuzumiyaAoba/counsel-ghq"))

;; ivy-posframe (GUI Emacs Only)
(use-package ivy-posframe
  :diminish ivy-posframe-mode
  :custom-face
  (ivy-posframe-border((t (:background "CornflowerBlue"))))
  :custom
  (ivy-posframe-display-functions-alist
   '((swiper . nil)
     (counsel-rg . nil)
     (t . ivy-posframe-display-at-frame-top-center)
     )
   )
  (ivy-posframe-mode 1)
  (ivy-posframe-parameters
   '((left-fringe . 8)
     (right-fringe . 8)))
  )

;; all the icons ivy 
(use-package all-the-icons-ivy
  :config
  (all-the-icons-ivy-setup))

(use-package ivy-rich
  :config
  (ivy-rich-mode -1))

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
  (migemo-init)
  )

;; ace-jump-buffer
(use-package ace-jump-buffer
  :bind 
  (("C-\\" . 'ace-jump-buffer))
  )

;; treemacs
(use-package treemacs)

;; beacon
(use-package beacon
  :diminish beacon-mode
  :config
  (beacon-mode t)
  :custom
  (beacon-size 10)
  (beacon-color 0.2)
  (beacon-blink-delay 0.1)
  (beacon-blink-when-focused t)
  )

(use-package zoom
  :diminish zoom-mode
  :custom
  (zoom-size '(0.618 . 0.618))
  :config
  (zoom-mode t)
  )

(use-package hungry-delete
  :diminish hungry-delete-mode
  :hook (prog-mode . hungry-delete-mode)
  )
