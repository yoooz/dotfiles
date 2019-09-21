;; yasnippet
(use-package yasnippet
  :diminish yas-minor-mode
  :config
  (yas-global-mode 1)
  :bind
  (:map yas-minor-mode-map
        ("C-x i i" . yas-insert-snippet)
        ("C-x i n" . yas-new-snippet)
        ("C-x i v" . yas-visit-snippet-file)
        )
  )

;; snippets
(use-package yasnippet-snippets)

;; Language Server Protocol
(use-package lsp-mode)
(use-package lsp-ui
  :custom
  ;; lsp-ui-doc
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-position 'top)
  (lsp-ui-doc-max-width 150)
  (lsp-ui-doc-max-height 30)
  (lsp-ui-doc-alignment 'frame)
  (lsp-ui-doc-border "SteelBlue")
  (lsp-ui-doc-use-childframe t)
  (lsp-ui-doc-use-webkit t)   
  (lsp-ui-doc-delay 0.1)
  ;; lsp-ui-flycheck
  (lsp-ui-flycheck-enable nil)
  ;; lsp-ui-sideline
  (lsp-ui-sideline-enable nil)
  (lsp-ui-sideline-ignore-duplicate t)
  (lsp-ui-sideline-show-symbol t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-diagnostics nil)
  (lsp-ui-sideline-show-code-actions nil)
  (lsp-ui-sideline-update-mode 'line)
  (lsp-ui-sideline-delay 0.1)
  ;; lsp-ui-imenu
  (lsp-ui-imenu-enable nil)
  (lsp-ui-imenu-kind-position 'top)
  ;; lsp-ui-peek
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-peek-height 20)
  (lsp-ui-peek-list-width 50)
  (lsp-ui-peek-always-show t)
  :bind
  (:map lsp-mode-map
        ("C-c C-r" . lsp-ui-peek-find-references)
        ("C-c C-j" . lsp-ui-peek-find-definitions)
        ("C-c i"   . lsp-ui-peek-find-implementation)
        ("C-c m"   . lsp-ui-imenu)
        ("C-c s"   . lsp-ui-sideline-mode))
  :custom-face
  (lsp-ui-doc-background ((t (:background "#282a36"))))
  :hook (lsp-mode . lsp-ui-mode)
  )

(use-package company-lsp)

;; company
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
   ("C-M-i" . company-complete)
   )
  )

;; language
(use-package python-mode
  :hook (python-mode . #'lsp)
  )
(use-package kotlin-mode)
(use-package gradle-mode)
(use-package android-mode)
(use-package apache-mode)
(use-package clojure-mode)
(use-package groovy-mode)
(use-package markdown-mode)
(use-package yaml-mode)
(use-package swift3-mode)
(use-package web-mode
  :mode
  (("\\.jsp\\'" . web-mode)
   ("\\.js\\'" . web-mode))
  )
(use-package dockerfile-mode)
(use-package go-mode)
