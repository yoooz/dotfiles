(use-package avy
  :defer t
  :custom
  (avy-background t)
  (avy-all-windows t)
  :custom-face
  (avy-lead-face ((t (:foreground "red" :background "#282a36"))))
  (avy-lead-face-0 ((t (:foreground "green" :background "#282a36"))))
  (avy-lead-face-1 ((t (:foreground "yellow" :background "#282a36"))))
  (avy-lead-face-2 ((t (:foreground "blue" :background "#282a36")))))

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

(use-package counsel
  :bind
  (("C-r" . counsel-M-x)
   ("C-x C-f" . counsel-find-file)))

(use-package counsel-ghq
  :straight (counsel-ghq :type git :host github :repo "yoooz/counsel-ghq")
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
  :defer t
  :config
  (avy-migemo-mode t)
  :bind
  (:map evil-normal-state-map
        ("C-;" . avy-migemo-goto-char-timer)))

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
