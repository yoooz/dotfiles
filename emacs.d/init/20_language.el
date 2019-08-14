;; yasnippet
(use-package yasnippet
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
  :config
  ;; lsp-ui-doc
  (custom-set-variables
   '(lsp-ui-doc-enable t)
   '(lsp-ui-doc-header t)
   '(lsp-ui-doc-include-signature t)
   '(lsp-ui-doc-position 'top)
   '(lsp-ui-doc-alignment 'frame)
   '(lsp-ui-doc-border "SteelBlue")
   '(lsp-ui-doc-use-childframe t)
   '(lsp-ui-doc-use-webkit t)   
   '(lsp-ui-doc-delay 0.1)
   )
  (custom-set-faces
   '(lsp-ui-doc-background ((t (:background "#282a36"))))
   )
  ;; lsp-ui-flycheck
  (custom-set-variables
   '(lsp-ui-flycheck-enable nil)
   )
  ;; lsp-ui-sideline
  (custom-set-variables
   '(lsp-ui-sideline-enable t)
   '(lsp-ui-sideline-ignore-duplicate t)
   '(lsp-ui-sideline-show-symbol t)
   '(lsp-ui-sideline-show-hover t)
   '(lsp-ui-sideline-show-diagnostics t)
   '(lsp-ui-sideline-show-code-actions t)
   '(lsp-ui-sideline-update-mode 'line)
   '(lsp-ui-sideline-delay 0.1)
   )
  ;; lsp-ui-imenu
  ;; lsp-ui-peek
  (custom-set-variables
   '(lsp-ui-peek-enable t)
   '(lsp-ui-peek-always-show t)
   )

  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  )

(use-package company-lsp)

;; company
(use-package company
  :config
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
  (push 'company-lsp company-backends)
  )

(use-package python-mode
  :config
  (add-hook 'python-mode-hook #'lsp))

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
