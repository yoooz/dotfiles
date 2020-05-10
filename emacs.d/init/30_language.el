(use-package yasnippet
  :diminish yas-minor-mode
  :config
  (yas-global-mode 1)
  :bind
  (:map yas-minor-mode-map
        ("C-x i i" . yas-insert-snippet)
        ("C-x i n" . yas-new-snippet)
        ("C-x i v" . yas-visit-snippet-file)))

(use-package yasnippet-snippets)

(use-package lsp-mode)
(use-package lsp-ui
  :custom
  ;; lsp-ui-doc
  (lsp-ui-doc-enable nil)
  ;; lsp-ui-flycheck
  (lsp-ui-flycheck-enable nil)
  ;; lsp-ui-sideline
  (lsp-ui-sideline-enable nil)
  (lsp-ui-sideline-ignore-duplicate t)
  (lsp-ui-sideline-update-mode 'point)
  (lsp-ui-sideline-delay 0.1)
  ;; lsp-ui-imenu
  (lsp-ui-imenu-enable nil)
  (lsp-ui-imenu-kind-position 'top)
  ;; lsp-ui-peek
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-peek-height 20)
  (lsp-ui-peek-list-width 50)
  (lsp-ui-peek-always-show nil)
  (lsp-ui-peek-fontify 'always)
  :bind
  (:map lsp-mode-map
        ("C-c C-r" . lsp-ui-peek-find-references)
        ("C-c C-j" . lsp-ui-peek-find-definitions)
        ("C-c i"   . lsp-ui-peek-find-implementation)
        ("C-c m"   . lsp-ui-imenu)
        ("C-c s"   . lsp-ui-sideline-mode))
  :custom-face
  (lsp-ui-peek-line-number ((t (:foreground "LightGreen"))))
  (lsp-ui-peek-highlight ((t (:background "LightGreen" :foreground "black" :box (:line-width 1 :color "black")))))
  ;(lsp-ui-doc-background ((t (:background "#282a36"))))
  :hook (lsp-mode . lsp-ui-mode))

(use-package company-lsp)

(use-package company
  :diminish company-mode
  :config
  (global-company-mode)
  (setq completion-ignore-case t)
  (push 'company-lsp company-backends)
  :custom 
  (company-transformers '(company-sort-by-backend-importance))
  (company-idle-delay 0)
  (company-minimum-prefix-lengh 2)
  (company-selection-wrap-around t)
  (company-dabbrev-minimum-length 2)
  (company-dabbrev-ignore-case t)
  (company-dabbrev-downcase nil)
  :bind
  (("C-M-i" . company-complete)
   :map company-active-map
   ("C-n" . company-select-next)
   ("C-p" . company-select-previous)
   ("C-s" . company-filter-candidates)
   ("C-i" . company-complete-selection)
   ([tab] . company-complete-selection)
   ("C-f" . company-complete-selection)
   :map company-search-map
   ("C-n" . company-select-next)
   ("C-p" . company-select-previous)
   :map emacs-lisp-mode-map
   ("C-M-i" . company-complete)))

;; language
;(use-package python-mode
;  :config
;  (add-hook 'python-mode-hook #'lsp)
;  )

(add-to-list 'exec-path "~/.ghq/github.com/fwcd/kotlin-language-server/server/build/install/server/bin")
(use-package kotlin-mode
  :config
  (add-hook 'kotlin-mode-hook #'lsp))
(use-package gradle-mode)
(use-package android-mode)
;(use-package apache-mode)
(use-package clojure-mode)
(use-package groovy-mode)
(use-package markdown-mode
  :mode
  (("\.txt$" . markdown-mode)))
(use-package yaml-mode)
(use-package swift-mode)
(use-package web-mode
  :mode
  (("\\.jsp\\'" . web-mode)
   ("\\.js\\'" . web-mode)))
(use-package dockerfile-mode)
(use-package go-mode
  :config
  (add-hook 'go-mode-hook #'lsp))
(use-package nxml-mode
  :mode
  (("\.xml$" . nxml-mode))
  :config
  (setq nxml-child-indent 2)
  (setq nxml-attribute-indent 2)
  (setq indent-tabs-mode nil)
  (setq nxml-slash-auto-complete-flag t)
  (setq tab-width 2))
