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

;; counsel-ghq
(use-package counsel-ghq
  :straight (counsel-ghq :type git :host github :repo "windymelt/counsel-ghq"))

;; ivy-posframe (GUI Emacs Only)
(use-package ivy-posframe
  :config
  (setq ivy-display-function #'ivy-posframe-display-at-frame-center)
  (ivy-posframe-enable)
  (setq ivy-posframe-parameters
        '((left-fringe . 8)
          (right-fringe . 8)))
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

;; package
(use-package package
  :config
  (add-to-list 'package-archives '("melpa". "http://melpa.milkbox.net/packages/"))
  (package-initialize)
  )

(use-package zoom
  :config
  (custom-set-variables
   '(zoom-size '(0.618 . 0.618))
   '(zoom-mode t)
   )
  )
