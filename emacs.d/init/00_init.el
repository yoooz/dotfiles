(use-package dashboard
  :config
  (setq dashboard-items '((recents . 30) ))
  (setq dashboard-startup-banner "~/dotfiles/emacs.d/swiper2.png")
  (setq dashboard-center-content t)
  (dashboard-setup-startup-hook))

(use-package doom-themes
  :custom
  (doom-themes-enable-italic t)
  (doom-themes-enable-bold t)
  :config
  (load-theme 'doom-snazzy t))

(use-package doom-modeline
  :defer t
  :hook (after-init . doom-modeline-mode)
  :custom 
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon nil)
  (doom-modeline-minor-modes nil)
  (doom-modeline-height 25)
  (doom-modeline-bar-width 3)
  (doom-modeline-buffer-file-name-style 'truncate-upto-root))

(use-package cl-lib)
(use-package color)
(use-package rainbow-delimiters
  :defer t
  :hook(prog-mode . rainbow-delimiters-mode))

(use-package rainbow-mode
  :defer t
  :hook(prog-mode . rainbow-mode)
  :diminish rainbow-mode)

(use-package auto-save-buffers-enhanced
  :config
  (setq auto-save-buffers-enhanced-interval 3)
  (auto-save-buffers-enhanced t)
  )

(use-package open-junk-file
  :defer t
  :config
  (setq open-junk-file-format "~/.junk/%Y/%m/%Y-%m%d-%H%M%S.md"))

(use-package snow
  :defer t
  :straight (snow :type git :host github :repo "alphapapa/snow.el"))

(use-package tempbuf
  :defer t
  :config
  (add-hook 'findfile-hooks 'turn-on-tempbuf-mode)
  (add-hook 'dired-mode-hook 'turn-on-tempbuf-mode))

(use-package iflipb
  :defer t
  :config
  (setq iflibp-ignore-buffers (list "^[*]" "^magit"))
  :bind
  (("M-o" . iflipb-next-buffer)
   ("M-O" . iflipb-previous-buffer))
  :custom
  (iflipb-wrap-around t))

(tab-bar-mode 1)
