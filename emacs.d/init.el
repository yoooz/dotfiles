;; char-code
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)

;; hide tool bar
(tool-bar-mode 0)
;; hide menu bar
(menu-bar-mode 0)

(scroll-bar-mode 0)

;;C-h Backspace
;;C-c h HELP
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

;; tab on Fundamental mode
(setq indent-line-function 'indent-to-left-margin)

;; tab 
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; auto-save
(setq backup-inhibited t)
(setq auto-save-default nil)
(setq ring-bell-function 'ignore)

;; auto-revert
(global-auto-revert-mode t)

;; scratch can not be killed
(with-current-buffer "*scratch*"
  (emacs-lock-mode 'kill))
(with-current-buffer "*Messages*"
  (emacs-lock-mode 'kill))

;; Corsor number
(column-number-mode t)
(line-number-mode t)

;; no blink
(blink-cursor-mode 0)

;; line-number
(global-display-line-numbers-mode t)

;; start up
(setq inhibit-startup-screen t)
;; not scratch
(setq initial-scratch-message "")

;; scroll
(setq scroll-conservatively 10
      next-screen-context-lines 10
      scroll-margin 10
      scroll-preserve-screen-position t)
(setq comint-scroll-show-maximum-output t)

;; ()
(show-paren-mode 1)
(setq show-paren-delay 0)

(add-hook 'prog-mode-hook #'hs-minor-mode)

(setq default-directory "~/")
(setq command-line-default-directory "~/")

;; straight.el setting by myself
(let ((bootstrap-file (concat user-emacs-directory "straight/repos/straight.el/bootstrap.el"))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; use-package
(straight-use-package 'use-package)

;; use-package fallback to straight.el automatically
(setq straight-use-package-by-default t)
;; report package loading status
(setq use-package-compute-statistics t)

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize)
)

;; init-loader
(use-package init-loader)

;; loading all el files under ~/.emacs.d/init/ 
(init-loader-load "~/.emacs.d/init")
