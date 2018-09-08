;;package
(require 'package)
(add-to-list 'package-archives '("melpa". "http://melpa.milkbox.net/packages/"))
;;(add-to-list 'package-archives '("marmalade". "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu". "http://elpa.gnu.org/packages"))
(add-to-list 'package-archives '("org". "http://orgmode.org/elpa"))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/inits")
(load "looks")

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


;;elscreen
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

;;Mozc
(add-to-list 'load-path "/usr/share/emacs24/site-lisp/emacs-mozc")
(require 'mozc)
(set-language-environment "Japanese")
(setq default-input-method "japanese-mozc")

(setq mozc-candidate-style 'echo-area)

;; 文字コード
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

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

;; tab on Fundamental mode
(setq indent-line-function 'indent-to-left-margin)

;; tab 
(setq-default indent-tabs-mode t)

(setq backup-inhibited t)
(setq auto-save-default nil)
(setq ring-bell-function 'ignore)
(set-clipboard-coding-system 'utf-8)
