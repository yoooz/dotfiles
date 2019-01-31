;;package
(require 'package)
(add-to-list 'package-archives '("melpa". "http://melpa.milkbox.net/packages/"))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/inits")
(load "looks")

;; 文字コード
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)

;;C-h Backspace
;;C-c h HELP
(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)
(global-set-key "\C-ch" 'help-command)

;; org
(setq org-agenda-files '("~/config/org_sample/todo.org"
                         "~/config/org_sample/list.org"))

;; all indent
(defun all-indent()
  (interactive)
  (mark-whole-buffer)
  (indent-region(region-beginning)(region-end))
  (point-undo))

(global-set-key(kbd "C-x C-]") 'all-indent)

;; tab on Fundamental mode
(setq indent-line-function 'indent-to-left-margin)

;; tab 
(setq-default tab-width 4 indent-tabs-mode nil)

(setq backup-inhibited t)
(setq auto-save-default nil)
(setq ring-bell-function 'ignore)

(global-set-key "\C-r" 'execute-extended-command)
(global-set-key "\C-l" 'avy-goto-word-0)

(global-auto-revert-mode t)

;; packages
(require 'swift-mode)
(require 'multiple-cursors)
(require 'smartrep)
(require 'elscreen)
(require 'tramp)
(require 'web-mode)
(require 'ivy)
(require 'symbol-overlay)
(require 'undo-tree)
(require 'smartparens-config)
(require 'volatile-highlights)
(require 'neotree)
(require 'company)
(require 'google-this)

;; smartrep & multiple-cursors
(declare-function smartrep-define-key "smartrep")
(global-unset-key "\C-t")
(smartrep-define-key global-map "C-t"
    '(("C-t" . 'mc/mark-next-like-this)
     ("n" . 'mc/mark-next-like-this)
     ("p" . 'mc/mark-previous-like-this)
     ("m" . 'mc/mark-more-like-this-extended)
     ("u" . 'mc/unmark-next-like-this)
     ("U" . 'mc/unmark-previous-like-this)
     ("s" . 'mc/skip-to-next-like-this)
     ("S" . 'mc/skip-to-previous-like-this)
     ("*" . 'mc/mark-all-like-this)
     ("d" . 'mc/mark-all-like-this-dwim)
     ("i" . 'mc/insert-numbers)
     ("o" . 'mc/sort-regions)
     ("O" . 'mc/reverse-regions)))

;;Elscreen
(elscreen-set-prefix-key "\C-z")
(setq elscreen-tab-display-kill-screen nil) ;[X]
(setq elscreen-tab-display-control nil) ;[<->]
(elscreen-start)

;;tramp
(setq tramp-defanult-method "ssh")

;;web-mode
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))

;; ivy
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-height 20) 
(setq ivy-extra-directories nil)
(setq ivy-re-builders-alist
      '((t . ivy--regex-plus)))

(global-set-key "\C-s" 'swiper)
(defvar swiper-include-line-number-in-search t)

;; symbol-overlay
(add-hook 'prog-mode-hook #'symbol-overlay-mode)
(add-hook 'markdown-mode-hook #'symbol-overlay-mode)
(global-set-key (kbd "M-i") 'symbol-overlay-put)
(define-key symbol-overlay-map (kbd "p") 'symbol-overlay-jump-prev) 
(define-key symbol-overlay-map (kbd "n") 'symbol-overlay-jump-next) 
(define-key symbol-overlay-map (kbd "C-g") 'symbol-overlay-remove-all) 

;; google-this
(with-eval-after-load "google-this"
    (defun my:google-this ()
      (interactive)
      (google-this (current-word) t)))

;; undo-tree
(global-undo-tree-mode t)

;; smartparens
(smartparens-global-mode t)

;; volatile-highlights
(volatile-highlights-mode t)

;; dumb-jump 
(setq dumb-jump-mode t)
(setq dumb-jump-selector 'ivy)
(setq dumb-jump-use-visible-window nil)

;; neotree
(setq neo-theme 'icons)
(setq neo-smart-open t)

;; company
(global-company-mode)
(setq company-transformers '(company-sort-by-backend-importance))
(setq company-idle-delay 0)
(setq company-minimum-prefix-lengh 2)
(setq company-selection-wrap-around t)
(setq completion-ignore-case t)
(setq company-dabbrev-downcase nil)
(global-set-key (kbd "C-M-i") 'company-complete)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)
(define-key company-active-map (kbd "C-i") 'company-complete-selection)
(define-key company-active-map [tab] 'company-complete-selection)
(define-key company-active-map (kbd "C-f") 'company-complete-selection)
(define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-diff-section-arguments (quote ("--no-ext-diff")))
 '(package-selected-packages
   (quote
    (swift-mode sudden-death avy diminish solarized-theme smart-mode-line smart-mode-line-atom-one-dark-theme flycheck company neotree dumb-jump ripgrep rg twittering-mode magit volatile-highlights smartparens undo-tree dashboard markdown-preview-mode uuidgen web-server websocket counsel web-mode symbol-overlay swiper swift3-mode smartrep multiple-cursors mozc hl-sentence hiwin google-this elscreen avy-migemo))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "#333333")))))
