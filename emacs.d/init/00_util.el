;; tramp
(use-package tramp
  :config
  (setq tramp-default-method "ssh")
  )

;; google-this
(use-package google-this)

;; ivy
(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-height 20)
  (setq ivy-extra-directories nil)
  (setq ivy-re-builders-alist
        '((t . ivy--regex-plus)))
  (global-set-key "\C-s" 'swiper)
  (defvar swiper-include-line-number-in-search t)
  )

;; counsel
(use-package counsel)

;; ivy-posframe (GUI Emacs Only)
(use-package ivy-posframe
  :config
  (setq ivy-display-function #'ivy-posframe-display-at-point)
  (ivy-posframe-enable)
  (setq ivy-posframe-parameters
        '((left-fringe . 8)
          (right-fringe . 8)))
  )

;; ace-jump-buffer
(use-package ace-jump-buffer
  :config
  (global-set-key (kbd "C-\\") 'ace-jump-buffer)
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
