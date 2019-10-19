(use-package doom-themes
  :custom
  (doom-themes-enable-italic t)
  (doom-themes-enable-bold t)
  :config
  (load-theme 'doom-snazzy t)
  ;;(load-theme 'doom-vibrant t)
  )

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :custom 
  (doom-modeline-height 25)
  (doom-modeline-bar-width 3)
  (doom-modeline-buffer-file-name-style 'truncate-all)
  )

(use-package dashboard
  :config
  (add-to-list 'dashboard-item-generators '(qiita . dashboard-qiita-insert))
  (setq dashboard-items '((recents . 15) (qiita . 15)))
  (setq dashboard-startup-banner "~/dotfiles/emacs.d/swiper2.png")
  (dashboard-setup-startup-hook)
  )

(use-package hide-mode-line
  :hook(treemacs-mode . hide-mode-line-mode)
  )

;; diminish
(use-package diminish
  :config
  (diminish 'emacs-lock-mode)
  (diminish 'eldoc-mode)
  )

;; rainbow delimiters
(use-package cl-lib)
(use-package color)
(use-package rainbow-delimiters
  :hook(prog-mode . rainbow-delimiters-mode)
  )

;; rainbow mode
(use-package rainbow-mode
  :hook(prog-mode . rainbow-mode)
  :diminish rainbow-mode
  )

(use-package hiwin
  :config
  (hiwin-activate)
  (set-face-background 'hiwin-face "gray10")
  )