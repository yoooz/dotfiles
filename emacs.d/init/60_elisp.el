(use-package lispxmp)

(defhydra hydra-training-elisp nil
  "elisp"
  ("l" lispxmp "lispxmp")
  ("c" comment-dwim "comment"))

(define-key emacs-lisp-mode-map (kbd "C-c C-e") 'hydra-training-elisp/body)

(use-package package
  :config
  (add-to-list 'package-archives '("melpa". "http://melpa.milkbox.net/packages/"))
  (package-initialize))

(defun set-alpha (alpha-num)
  "set frame parameter 'alpha"
  (interactive "nAlpha: ")
  (set-frame-parameter nil 'alpha (cons alpha-num '(90))))
