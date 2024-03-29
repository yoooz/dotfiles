(use-package ace-window
  :defer t
  :custom
  (aw-keys '(?j ?k ?l ?i ?o ?h ?y ?u ?p))
  (aw-dispatch-always t)
  :custom-face
  (aw-leading-char-face ((t (:height 4.0 :foreground "#f1fa8c")))))

(use-package ivy
  :diminish ivy-mode
  :config
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

(use-package ivy-posframe
  :config
  (setq ivy-posframe-display-functions-alist
        '((t . ivy-posframe-display-at-frame-center)))
  (setq ivy-posframe-parameters
        '((left-fringe . 8)
          (right-fringe . 8)
          (border-width . 8)))
  (ivy-posframe-mode 1)
  :custom
  (custom-set-faces
   `(ivy-posframe-border ((t (:background ,(doom-color 'bg)))))
   `(ivy-posframe ((t (:background "black"))))))

(use-package counsel
  :bind
  (("C-r" . counsel-M-x)
   ("C-x C-f" . counsel-find-file)))

(use-package counsel-ghq
  :straight (counsel-ghq :type git :host github :repo "yoooz/counsel-ghq")
  :defer t
  :config
  (ivy-set-actions 'counsel-ghq
                   '(("g" counsel-git "Open Git"))))

(use-package all-the-icons-ivy
  :config
  (all-the-icons-ivy-setup))

(use-package all-the-icons-ivy-rich
  :init (all-the-icons-ivy-rich-mode t))

(use-package ivy-rich
  :config
  (ivy-rich-mode t))

(use-package projectile)

(use-package restclient
  :defer t)

(defun advice-completing-read-to-ivy (orig-func &rest args)
  (interactive
   (let* ((recent-tabs (mapcar (lambda (tab)
                                 (alist-get 'name tab))
                               (tab-bar--tabs-recent))))
     (list (ivy-completing-read "Switch to tab by name (default recent): "
                                recent-tabs nil nil nil nil recent-tabs))))
  (apply orig-func args))
(advice-add #'tab-bar-switch-to-tab :around #'advice-completing-read-to-ivy)
(advice-add #'tab-bar-close-tab-by-name :around #'advice-completing-read-to-ivy)
