(use-package dashboard
  :config
  (setq dashboard-items '((recents . 15) ))
  (setq dashboard-startup-banner "~/dotfiles/emacs.d/swiper2.png")
  (dashboard-setup-startup-hook))

(use-package doom-themes
  :custom
  (doom-themes-enable-italic t)
  (doom-themes-enable-bold t)
  :config
  (load-theme 'doom-snazzy t))

(use-package doom-modeline
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

;; howm
(use-package howm
  :custom
  (howm-file-name-format "%Y/%m/%Y_%m_%d.txt")
  (howm-menu-lang 'ja)
  (howm-keyword-case-fold-search t)
  :init
  (setq howm-keyword-file "~/howm/.howm-keys")
  (setq action-lock-no-browser t)
  (defvar howm-view-title-header "# ")
  (defvar datetime-format "%Y-%m-%dT%H:%M:%S")
  (setq howm-template-date-format
        (concat "[" datetime-format "]"))
  )

(defun my-lisp-load (filename)
  "Load lisp from FILENAME"
  (let ((fullname (expand-file-name (concat "spec/" filename) user-emacs-directory))
        lisp)
    (when (file-readable-p fullname)
      (with-temp-buffer
        (progn
          (insert-file-contents fullname)
          (setq lisp 
                (condition-case nil
                    (read (current-buffer))
                  (error ()))))))
    lisp))

(use-package auto-save-buffers-enhanced
  :config
  (setq auto-save-buffers-enhanced-interval 3)
  (auto-save-buffers-enhanced t)
  )

(use-package org-trello
  :custom
  (org-trello-files '("~/howm/trello.org")))

(use-package open-junk-file
  :defer t
  :config
  (setq open-junk-file-format "~/howm/junk/%Y/%m/%Y-%m%d-%H%M%S.md"))

(use-package snow
  :straight (snow :type git :host github :repo "alphapapa/snow.el"))

(use-package tempbuf
  :config
  (add-hook 'findfile-hooks 'turn-on-tempbuf-mode)
  (add-hook 'dired-mode-hook 'turn-on-tempbuf-mode))

(use-package iflipb
  :config
  (setq iflibp-ignore-buffers (list "^[*]" "^magit"))
  :bind
  (("M-o" . iflipb-next-buffer)
   ("M-O" . iflipb-previous-buffer))
  :custom
  (iflipb-wrap-around t))
