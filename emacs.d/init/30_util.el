;; tramp
(use-package tramp
  :config
  (setq tramp-default-method "ssh")
  )

;; google-this
(use-package google-this)

;; avy
(use-package avy
  :config
  (setq avy-background t)
  (custom-set-faces
   '(avy-lead-face ((t (:foreground "red" :background "black"))))
   '(avy-lead-face-0 ((t (:foreground "green" :background "black"))))
   '(avy-lead-face-1 ((t (:foreground "yellow" :background "black"))))
   '(avy-lead-face-2 ((t (:foreground "blue" :background "black"))))
   )
  :bind
  (
   ("C-l" . avy-goto-word-1))
  )

;; ace-window
(use-package ace-window
  :config
  (custom-set-variables
   '(aw-keys '(?j ?k ?l ?i ?o ?h ?y ?u ?p))
   )
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
  (custom-set-variables
   '(swiper-include-line-number-in-search t)
   '(ivy-use-virtual-buffers t)
   '(ivy-height 20)
   '(ivy-extra-directories nil)
   '(ivy-format-functions-alist '((t . ivy-format-function-arrow)))
   )
  :bind
  ("C-s" . swiper)
  )

;; counsel
(use-package counsel
  :bind
  (("C-r" . execute-extended-command))
  )

;; counsel-ghq
(use-package counsel-ghq
  :straight (counsel-ghq :type git :host github :repo "SuzumiyaAoba/counsel-ghq"))

;; ivy-posframe (GUI Emacs Only)
(use-package ivy-posframe
  :diminish ivy-posframe-mode
  :config
  (custom-set-faces
   '(ivy-posframe-border((t (:background "CornflowerBlue"))))
   )
  (custom-set-variables
   '(ivy-posframe-display-functions-alist
     '((swiper . nil)
       (t . ivy-posframe-display-at-frame-top-center)
       )
     )
   '(ivy-posframe-mode 1)
   '(ivy-posframe-parameters
        '((left-fringe . 8)
          (right-fringe . 8)))
   )
  )

(use-package migemo
  :config
  (setq migemo-command "cmigemo")
  (setq migemo-options '("-q" "--emacs"))
 
  ;; Set your installed path
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
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
  (custom-set-variables
   '(beacon-size 10)
   '(beacon-color 0.2)
   '(beacon-blink-delay 0.1)
   '(beacon-blink-when-focused t))
  )

(use-package zoom
  :diminish zoom-mode
  :config
  (custom-set-variables
   '(zoom-size '(0.618 . 0.618))
   '(zoom-mode t)
   )
  )

(use-package hungry-delete
  :diminish hungry-delete-mode
  :hook
  ((prog-mode) . hungry-delete-mode)
  )
