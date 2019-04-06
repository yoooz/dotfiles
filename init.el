;; 何も考えず公式のREADMEからコピペすればいいコード
;; straight.el自身のインストールと初期設定を行ってくれる
(let ((bootstrap-file (concat user-emacs-directory "straight/repos/straight.el/bootstrap.el"))
      (bootstrap-version 3))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; use-packageをインストールする
(straight-use-package 'use-package)
;; package
(require 'package)
(add-to-list 'package-archives '("melpa". "http://melpa.milkbox.net/packages/"))
(package-initialize)

;; オプションなしで自動的にuse-packageをstraight.elにフォールバックする
;; 本来は (use-package hoge :straight t) のように書く必要がある
(setq straight-use-package-by-default t)

;; init-loaderをインストール&読み込み
(use-package init-loader)

;; ~/.emacs.d/init/ 以下のファイルを全部読み込む
(init-loader-load "~/.emacs.d/init")

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
(straight-use-package 'swift-mode)
(use-package 'swift-mode)

;;web-mode
(straight-use-package 'web-mode)
(use-package 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))

;; undo-tree
(straight-use-package 'undo-tree)
(use-package 'undo-tree)
(global-undo-tree-mode t)

;; neotree
(straight-use-package 'neotree)
(use-package 'neotree)
(setq neo-theme 'icons)
(setq neo-smart-open t)

;; howm
(straight-use-package 'howm)
(usepackage 'howm)
(setq howm-directory (concat user-emacs-directory "howm"))
(setq howm-menu-lang 'ja)
(setq howm-file-name-format "%Y/%m/%Y-%m-%d.howm")
(define-key global-map (kbd "C-c ,,") 'howm-menu)

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
