(use-package evil
  :custom
  (evil-disable-insert-state-bindings t)
  :config
  (setq evil-cross-lines t)
  (setq evil-search-module 'isearch)
  (evil-mode 1)
  (setq evil-want-fine-undo t)
  (setq evil-esc-delay 0)
  (setq evil-insert-state-cursor '("#ff6ac1" bar))  ;; snazzy-themeのmagenta
  (setq evil-normal-state-cursor '("#57c7ff" box)) ;; snazzy-themeのblue
  )

(global-set-key "\C-g" 'evil-normal-state)
;; メインはUSキーボードなので ; と : を入れ替える
(define-key evil-normal-state-map (kbd ";") 'evil-ex)
(define-key evil-normal-state-map (kbd ":") 'evil-repeat-find-char)

(use-package key-chord
  :commands (key-chord-mode)
  :init
  (setq key-chord-two-keys-delay 0.5)
  (key-chord-define-global "jj" 'evil-normal-state))

;; key-chordが途中で切れることがあるので、emacs-stateに入るたびにONにする
(add-hook 'evil-insert-state-entry-hook (lambda()
                                         (key-chord-mode 1)))
(add-hook 'evil-insert-state-exit-hook (lambda()
                                         (key-chord-mode nil)))

;; howm
(use-package howm
  :custom
  (howm-file-name-format "%Y/%m/%Y_%m_%d.txt")
  (howm-menu-lang 'ja)
  (howm-keyword-case-fold-search t)
  :config
  (setq howm-keyword-file "~/howm/.howm-keys")
  (setq action-lock-no-browser t)
  (defvar howm-view-title-header "# ")
  (defvar datetime-format "%Y-%m-%dT%H:%M:%S")
  (setq howm-template-date-format
        (concat "[" datetime-format "]"))
  )

(defun my-lisp-load (filename)
  "Load lisp from FILENAME"
  (let ((fullname (expand-file-name (concat "spec/" filename) user-emacs-directory))
        lisp)
    (when (file-readable-p fullname)
      (with-temp-buffer
        (progn
          (insert-file-contents fullname)
          (setq lisp 
                (condition-case nil
                    (read (current-buffer))
                  (error ()))))))
    lisp))

(use-package auto-save-buffers-enhanced
  :config
  (setq auto-save-buffers-enhanced-interval 3)
  (auto-save-buffers-enhanced t)
  )
