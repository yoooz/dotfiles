;; smart mode line
(defvar sml/no-confirm-load-theme t)
(defvar sml/theme 'dark)
(defvar sml/shorten-directory -1)
(sml/setup)

;; diminish
(require 'diminish)
(eval-after-load "company" '(diminish 'company-mode "comp"))
(eval-after-load "ivy" '(diminish 'ivy-mode))
(eval-after-load "flycheck" '(diminish 'flycheck "fc"))
(eval-after-load "Undo-Tree" '(diminish 'Undo-Tree))
(eval-after-load "volatile-highlights" '(diminish 'volatile-highlights))
(eval-after-load "eldoc" '(diminish 'eldoc))

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

;;high light
(global-hl-line-mode t)
(custom-set-faces
 ;; '(hl-line ((t (:background "pink"))))
  '(hl-line ((t (:background "#333333"))))
 )

;;Corsor number
(column-number-mode t)
(line-number-mode t)

;;no blink
(blink-cursor-mode 0)

;; 行番号
(global-linum-mode t)
(setq linum-format "%d ")
(set-face-attribute 'linum nil
                    :foreground "black"
                    :background "white"
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

;;非アクティブウィンドウの背景色を設定
(require 'hiwin)
(hiwin-activate)
(set-face-background 'hiwin-face "#3a3939")
