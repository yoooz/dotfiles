(use-package tree-sitter)
(use-package tree-sitter-langs)

(use-package yasnippet
  :defer t
  :diminish yas-minor-mode
  :config
  (yas-global-mode 1)
  :bind
  (:map yas-minor-mode-map
        ("C-x i i" . yas-insert-snippet)
        ("C-x i n" . yas-new-snippet)
        ("C-x i v" . yas-visit-snippet-file)))

(use-package yasnippet-snippets
  :defer t)

(use-package lsp-mode
  :defer t
  :custom
  ;; debug
  (lsp-print-io t)
  (lsp-log-io t)
  (lsp-trace t)
  (lsp-print-performance t)
  ;; general
  (lsp-auto-guess-root t)
  (lsp-document-sync-method 'incremental)
  (lsp-response-timeout 5)
  (lsp-prefer-flymake 'flymake)
  (lsp-enable-completion-at-point nil)
  ;; completion
  (lsp-completion-enable t)
  (lsp-completion-show-detail t)
  (lsp-completion-show-kind t)
  (lsp-completion-show-label-description t))

(use-package flymake-posframe
  :straight (flymake-posframe :type git :host github :repo "Ladicle/flymake-posframe")
  :hook (flymake-mode . flymake-posframe-mode))

(use-package dap-mode
  :defer t
  :after lsp-mode
  :config
  (dap-mode 1)
  (dap-auto-configure-mode 1)
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  (dap-ui-controls-mode 1)
  (require 'dap-hydra)
  (require 'dap-dlv-go)
  (add-hook 'dap-stopped-hook
            (lambda (arg) (call-interactively #'dap-hydra)))
  :custom
  (dap-auto-configure-features '(sessions locals breakpoints expressions repl controls tooltip)))

(use-package lsp-ui
  :defer t
  :custom
  ;; lsp-ui-doc
  (lsp-ui-doc-enable nil)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-position 'top)
  (lsp-ui-doc-use-childframe t)
  (lsp-ui-doc-use-webkit t)
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
        ("C-c C-b" . lsp-ui-peek-jump-backward)
        ("C-c C-]" . lsp-ui-peek-jump-forward)
        ("C-c i"   . lsp-ui-peek-find-implementation)
        ("C-c m"   . lsp-ui-imenu)
        ("C-c s"   . lsp-ui-sideline-mode))
  :custom-face
  (lsp-ui-peek-line-number ((t (:foreground "LightGreen"))))
  (lsp-ui-peek-highlight ((t (:background "LightGreen" :foreground "black" :box (:line-width 1 :color "black")))))
  ;(lsp-ui-doc-background ((t (:background "#282a36"))))
  :hook (lsp-mode . lsp-ui-mode))

(use-package lsp-treemacs
  :defer t
  :hook (lsp-mode . lsp-treemacs-sync-mode))

(use-package company-box
  :defer t
  :hook (company-mode . company-box-mode))

(use-package company
  :defer t
  :diminish company-mode
  :init
  (setq completion-ignore-case t)
  :hook (prog-mode . company-mode)
  :custom 
  (company-transformers '(company-sort-by-backend-importance))
  (company-idle-delay 0)
  (company-minimum-prefix-lengh 1)
  (company-selection-wrap-around t)
  (company-dabbrev-minimum-length 2)
  (company-dabbrev-ignore-case t)
  (company-dabbrev-downcase nil)
  (company-dabbrev-code-ignore-case t)
  :bind
  (("M-i" . company-complete)
   :map company-active-map
   ("C-n" . company-select-next)
   ("C-p" . company-select-previous)
   :map company-search-map
   ("C-n" . company-select-next)
   ("C-p" . company-select-previous)))

(use-package markdown-mode
  :defer
  :mode
  (("\.txt$" . markdown-mode))
  :custom-face
  (markdown-header-face-1 ((t  (:foreground "White" :background "DeepSkyBlue1" :weight bold))))
  (markdown-header-face-2 ((t  (:foreground "maroon1" :weight bold))))
  (markdown-header-face-3 ((t  (:foreground "SkyBlue1" :weight bold))))
  (markdown-header-face-4 ((t  (:foreground "burlywood1" :weight bold))))
  (markdown-header-face-5 ((t  (:foreground "OliveDrab1" :weight bold))))
  (markdown-header-face-6 ((t  (:foreground "orange1" :weight bold)))))

(use-package yaml-mode
  :defer t)

(use-package dockerfile-mode
  :defer t)

(use-package go-mode
  :defer t
  :config
  (add-hook 'go-mode-hook #'lsp)
  (add-hook 'go-mode-hook #'tree-sitter-mode)
  (add-hook 'go-mode-hook #'tree-sitter-hl-mode))
