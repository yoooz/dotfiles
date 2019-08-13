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

;; ivy
(use-package ivy
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
   '())
  :bind
  ("C-s" . swiper)
  )

;; counsel
(use-package counsel
  :bind
  (("C-r" . counsel-M-x))
  )

;; counsel-ghq
(use-package counsel-ghq
  :straight (counsel-ghq :type git :host github :repo "windymelt/counsel-ghq"))

;; ivy-posframe (GUI Emacs Only)
(use-package ivy-posframe
  :config
  (custom-set-faces
   '(ivy-posframe-border((t (:background "CornflowerBlue"))))
   )
  (custom-set-variables
   '(ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-point)))
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
  :config
  (beacon-mode t)
  (custom-set-variables
   '(beacon-size 10)
   '(beacon-color 0.2)
   '(beacon-blink-delay 0.1)
   '(beacon-blink-when-focused t))
  )

(use-package zoom
  :config
  (custom-set-variables
   '(zoom-size '(0.618 . 0.618))
   '(zoom-mode t)
   )
  )

(use-package hungry-delete
  :hook
  ((prog-mode) . hungry-delete-mode)
  )
