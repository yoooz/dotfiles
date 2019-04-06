;;package
(require 'package)
(add-to-list 'package-archives '("melpa". "http://melpa.milkbox.net/packages/"))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/inits")
(load "looks")
(load "myorg")
(load "coding")

;; 文字コード
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)

;;C-h Backspace
;;C-c h HELP
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))

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

;; auto-save
(setq backup-inhibited t)
(setq auto-save-default nil)
(setq ring-bell-function 'ignore)

;; auto-revert
(global-auto-revert-mode t)

(global-set-key "\C-r" 'execute-extended-command)
(global-set-key "\C-l" 'avy-goto-word-0)

;; packages
(require 'swift-mode)
(require 'elscreen)
(require 'tramp)
(require 'web-mode)
(require 'ivy)
(require 'undo-tree)
(require 'neotree)
(require 'google-this)
(require 'howm)
(require 'ace-jump-buffer)

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

;; google-this
(with-eval-after-load "google-this"
    (defun my:google-this ()
      (interactive)
      (google-this (current-word) t)))

;; undo-tree
(global-undo-tree-mode t)

;; neotree
(setq neo-theme 'icons)
(setq neo-smart-open t)

;; howm
(setq howm-directory (concat user-emacs-directory "howm"))
(setq howm-menu-lang 'ja)
(setq howm-file-name-format "%Y/%m/%Y-%m-%d.howm")
(define-key global-map (kbd "C-c ,,") 'howm-menu)

;; ace-jump-buffer
(global-set-key (kbd "C-\\") 'ace-jump-buffer)

;; scratch can not be killed
(with-current-buffer "*scratch*"
  (emacs-lock-mode 'kill))
(with-current-buffer "*Messages*"
  (emacs-lock-mode 'kill))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-diff-section-arguments (quote ("--no-ext-diff")))
 '(package-selected-packages
   (quote
    (mew kosmos-theme markdown-mode ace-jump-buffer swift-mode sudden-death avy diminish solarized-theme smart-mode-line smart-mode-line-atom-one-dark-theme flycheck company neotree dumb-jump ripgrep rg twittering-mode magit volatile-highlights smartparens undo-tree dashboard markdown-preview-mode uuidgen web-server websocket counsel web-mode symbol-overlay swiper swift3-mode smartrep multiple-cursors hl-sentence hiwin google-this elscreen))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "#333333")))))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
