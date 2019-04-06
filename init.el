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

;; オプションなしで自動的にuse-packageをstraight.elにフォールバックする
;; 本来は (use-package hoge :straight t) のように書く必要がある
(setq straight-use-package-by-default t)

;; init-loaderをインストール&読み込み
(use-package init-loader)

;; ~/.emacs.d/init/ 以下のファイルを全部読み込む
;(init-loader-load "~/.emacs.d/init")

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
(use-package 'swift-mode)

;;web-mode
(use-package 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))

;; undo-tree
(use-package 'undo-tree)
(global-undo-tree-mode t)

;; neotree
(use-package 'neotree)
(setq neo-theme 'icons)
(setq neo-smart-open t)

;; howm
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
