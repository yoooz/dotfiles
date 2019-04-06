;; tramp
(require 'tramp)
(setq tramp-default-method "ssh")

;; elscreen
(require 'elscreen)
(elscreen-set-prefix-key "\C-z")
(setq elscreen-tab-display-kill-screen nil) ;[X]
(setq elscreen-tab-display-control nil) ;[<->]
(elscreen-start)

;; google-this
(require 'google-this)
(with-eval-after-load "google-this"
  (defun my:google-this ()
    (interactive)
    (google-this (current-word) t)))

;; ivy
(require 'ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-height 20)
(setq ivy-extra-directories nil)
(setq ivy-re-builders-alist
      '((t . ivy--regex-plus)))
(global-set-key "\C-s" 'swiper)
(defvar swiper-include-line-number-in-search t)

;; ace-jump-buffer
(require 'ace-jump-buffer)
(global-set-key (kbd "C-\\") 'ace-jump-buffer)
