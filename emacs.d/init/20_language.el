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
  (lsp-ui-doc-alignment 'frame)
  (lsp-ui-doc-border "SteelBlue")
  (lsp-ui-doc-use-childframe t)
  (lsp-ui-doc-use-webkit t)   
  (lsp-ui-doc-delay 0.1)
  ;; lsp-ui-flycheck
  (lsp-ui-flycheck-enable nil)
  ;; lsp-ui-sideline
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-ignore-duplicate t)
  (lsp-ui-sideline-show-symbol t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-code-actions t)
  (lsp-ui-sideline-update-mode 'line)
  (lsp-ui-sideline-delay 0.1)
  ;; lsp-ui-imenu
  ;; lsp-ui-peek
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-always-show t)
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

(use-package python-mode
  :hook (python-mode . lsp-mode)
  )

;; kotlin
(use-package kotlin-mode)

;; Groovy
(use-package groovy-mode)

;; markdown
(use-package markdown-mode)

;; yaml
(use-package yaml-mode)

;; swift3
(use-package swift3-mode)

;; web-mode
(use-package web-mode
  :mode
  (("\\.jsp\\'" . web-mode))
  )

;; dockerfile-mode
(use-package dockerfile-mode)
