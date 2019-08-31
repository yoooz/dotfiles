(use-package lispxmp)

(defhydra hydra-training-elisp nil
  "elisp"
  ("l" lispxmp "lispxmp")
  ("c" comment-dwim "comment"))

(define-key emacs-lisp-mode-map (kbd "C-c C-e") 'hydra-training-elisp/body)

;; package
(use-package package
  :config
  (add-to-list 'package-archives '("melpa". "http://melpa.milkbox.net/packages/"))
  (package-initialize)
  )
