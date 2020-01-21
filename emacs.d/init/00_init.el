(use-package evil
  :config
  (setq evil-cross-lines t)
  (setq evil-search-module 'isearch)
  (defalias 'evil-insert-state 'evil-emacs-state)
  (evil-mode 1)
  (setq evil-want-fine-undo t)
  (setq evil-esc-delay 0)
  (setq evil-emacs-state-cursor '("#ff6ac1" bar))  ;; snazzy-themeのmagenta
  (setq evil-normal-state-cursor '("#57c7ff" box)) ;; snazzy-themeのblue
  )

(define-key evil-emacs-state-map (kbd "<escape>") 'evil-normal-state)
(define-key evil-emacs-state-map (kbd "C-g") 'evil-normal-state)
(define-key evil-normal-state-map (kbd "gg") 'goto-line)
;; メインはUSキーボードなので ; と : を入れ替える
(define-key evil-normal-state-map (kbd ";") 'evil-ex)
(define-key evil-normal-state-map (kbd ":") 'evil-repeat-find-char)

(use-package key-chord
  :config
  (setq key-chord-two-keys-delay 0.5)
  (key-chord-define evil-emacs-state-map "jj" 'evil-normal-state)
  (key-chord-mode 1))

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
