;; tramp
(use-package tramp)
(setq tramp-default-method "ssh")

;; elscreen
(use-package elscreen)
(elscreen-set-prefix-key "\C-z")
(setq elscreen-tab-display-kill-screen nil) ;[X]
(setq elscreen-tab-display-control nil) ;[<->]
(elscreen-start)

;; google-this
(use-package google-this)
(with-eval-after-load "google-this"
  (defun my:google-this ()
    (interactive)
    (google-this (current-word) t)))

;; ivy
(use-package ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-height 20)
(setq ivy-extra-directories nil)
(setq ivy-re-builders-alist
      '((t . ivy--regex-plus)))
(global-set-key "\C-s" 'swiper)
(defvar swiper-include-line-number-in-search t)

;; counsel
(use-package counsel)

;; ace-jump-buffer
(use-package ace-jump-buffer)
(global-set-key (kbd "C-\\") 'ace-jump-buffer)

;; neotree
(use-package neotree)

;; beacon
(use-package beacon)
(beacon-mode t)
