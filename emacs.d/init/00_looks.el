;; smart mode line
(use-package smart-mode-line)
(setq sml/no-confirm-load-theme t)
(defvar sml/no-confirm-load-theme t)
(defvar sml/theme 'dark)
(defvar sml/shorten-directory -1)
(sml/setup)

;; diminish
(use-package diminish)
(eval-after-load "company" '(diminish 'company-mode))
(eval-after-load "volatile-highlights" '(diminish 'volatile-highlights-mode))
(eval-after-load "undo-tree" '(diminish 'undo-tree-mode))
(eval-after-load "ivy" '(diminish 'ivy-mode))
(eval-after-load "eldoc" '(diminish 'eldoc-mode))
(eval-after-load "smartparens" '(diminish 'smartparens-mode))
(eval-after-load "symbol-overlay" '(diminish 'symbol-overlay-mode))

;;color
(if window-system (progn
		    (set-face-foreground 'font-lock-comment-face "MediumSeaGreen")
		    (set-face-foreground 'font-lock-string-face "lightskyblue")
		    (set-face-foreground 'font-lock-keyword-face "NavajoWhite")
		    (set-face-foreground 'font-lock-function-name-face "NavajoWhite")
		    (set-face-bold-p 'font-lock-function-name-face t)
		    (set-face-foreground 'font-lock-variable-name-face "lawn green")
		    (set-face-foreground 'font-lock-type-face "LightSeaGreen")
		    (set-face-foreground 'font-lock-builtin-face "medium aquamarine")
		    (set-face-foreground 'font-lock-warning-face "blue")
		    (set-background-color "Black")
		    (set-foreground-color "LightGray")
		    (set-cursor-color "White")
		    (set-frame-parameter nil 'alpha 90)
		    ))

;; color magit
(use-package magit)
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-added "#00FF00")
     (set-face-background 'magit-diff-added "#000000")
     (set-face-foreground 'magit-diff-added-highlight "#00FF00")
     (set-face-background 'magit-diff-added-highlight "#gray20")
     
     (set-face-foreground 'magit-diff-removed "#FF0000")
     (set-face-background 'magit-diff-removed "#000000")
     (set-face-foreground 'magit-diff-removed-highlight "#FF0000")
     (set-face-background 'magit-diff-removed-highlight "gray20")))

;;high light
(global-hl-line-mode t)
(custom-set-faces
  '(hl-line ((t (:background "#610243"))))
 )

;;Corsor number
(column-number-mode t)
(line-number-mode t)

;;no blink
(blink-cursor-mode 0)

;; 行番号
(global-linum-mode t)
(setq linum-format "%3d| ")
(set-face-attribute 'linum nil
                    :foreground "white"
                    :height 0.9)

;;start up
(setq inhibit-startup-screen t)
;;not scratch
(setq initial-scratch-message "")

;; scroll
(setq scroll-conservatively 35
      next-screen-context-lines 10
      scroll-margin 20
      scroll-preserve-screen-position t)
(setq comint-scroll-show-maximum-output t)

;; ()
(show-paren-mode 1)
(setq show-paren-delay 0)
