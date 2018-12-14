;;package
(require 'package)
(add-to-list 'package-archives '("melpa". "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("melpa.org". "http://melpa.org/packages/"))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/inits")
(load "looks")

(require 'swift3-mode)
(require 'multiple-cursors)
(require 'smartrep)

(declare-function smartrep-define-key "smartrep")

(global-set-key (kbd "C-M-c") 'mc/edit-lines)
(global-set-key (kbd "C-M-r") 'mc/mark/all-in-region)

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
     ("*" . 'mc/mark-all-like-thi)
     ("d" . 'mc/mark-all-like-this-dwim)
     ("i" . 'mc/insert-numbers)
     ("o" . 'mc/sort-regions)
     ("O" . 'mc/reverse-regions)))

;; scroll
(setq next-screen-context-lines 10)
(setq scroll-conservatively 35)
(setq scroll-margin 20)
(setq scroll-preserve-screen-position t)

;;Elscreen
(require 'elscreen)
(elscreen-set-prefix-key "\C-z")
(global-set-key "\C-r" 'elscreen-next)
(global-set-key "\C-l" 'elscreen-previous)
;;[X], [<->]を表示しない
(setq elscreen-tab-display-kill-screen nil)
(setq elscreen-tab-display-control nil)
(elscreen-start)

;;tramp
(require 'tramp)
(setq tramp-defanult-method "scpx")

;;web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))

;;Mozc
(add-to-list 'load-path "/usr/share/emacs24/site-lisp/emacs-mozc")
(require 'mozc)
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")

(setq mozc-candidate-style 'echo-area)

;; 文字コード
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

;; 行番号
(global-linum-mode t)
(setq linum-format "%d ")
(set-face-attribute 'linum nil
                    :foreground "black"
                    :background "white"
                    :height 0.9)

;;C-h Backspace
;;C-c h HELP
(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)
(global-set-key "\C-ch" 'help-command)

;; all indent
(defun all-indent()
  (interactive)
  (mark-whole-buffer)
  (indent-region(region-beginning)(region-end))
  (point-undo))

(global-set-key(kbd "C-x C-]") 'all-indent)

;; ivy
(require 'ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-height 20) 
(setq ivy-extra-directories nil)
(setq ivy-re-builders-alist
      '((t . ivy--regex-plus)))

;; counsel
(defvar counsel-find-file-ignore-regexp (regexp-opt '("./" "../")))

(global-set-key "\C-s" 'swiper)
(defvar swiper-include-line-number-in-search t)

;; migemo + swiper
(require 'avy-migemo)
(avy-migemo-mode 1)
(require 'avy-migemo-e.g.swiper)

;; symbol-overlay
(require 'symbol-overlay)
(add-hook 'prog-mode-hook #'symbol-overlay-mode)
(add-hook 'markdown-mode-hook #'symbol-overlay-mode)
(global-set-key (kbd "M-i") 'symbol-overlay-put)
(define-key symbol-overlay-map (kbd "p") 'symbol-overlay-jump-prev) 
(define-key symbol-overlay-map (kbd "n") 'symbol-overlay-jump-next) 
(define-key symbol-overlay-map (kbd "C-g") 'symbol-overlay-remove-all) 

(require 'google-this)
(with-eval-after-load "google-this"
    (defun my:google-this ()
      (interactive)
      (google-this (current-word) t)))

;; tab on Fundamental mode
(setq indent-line-function 'indent-to-left-margin)

;; tab 
(setq-default tab-width 4 indent-tabs-mode nil)

(setq backup-inhibited t)
(setq auto-save-default nil)
(setq ring-bell-function 'ignore)
(set-clipboard-coding-system 'utf-8)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(avy-migemo-function-names
   (quote
    (swiper--add-overlays-migemo
     (swiper--re-builder :around swiper--re-builder-migemo-around)
     (ivy--regex :around ivy--regex-migemo-around)
     (ivy--regex-ignore-order :around ivy--regex-ignore-order-migemo-around)
     (ivy--regex-plus :around ivy--regex-plus-migemo-around)
     ivy--highlight-default-migemo ivy-occur-revert-buffer-migemo ivy-occur-press-migemo avy-migemo-goto-char avy-migemo-goto-char-2 avy-migemo-goto-char-in-line avy-migemo-goto-char-timer avy-migemo-goto-subword-1 avy-migemo-goto-word-1 avy-migemo-isearch avy-migemo-org-goto-heading-timer avy-migemo--overlay-at avy-migemo--overlay-at-full)))
 '(package-selected-packages
   (quote
    (google-this symbol-overlay swiper avy-migemo counsel swift3-mode smartrep multiple-cursors mozc hiwin elscreen))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "#333333")))))
