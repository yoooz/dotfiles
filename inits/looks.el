;;メニューバーにファイルパス
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

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

;;start up
(setq inhibit-startup-screen t)
;;not scratch
(setq initial-scratch-message "")

;;
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)
(setq comint-scroll-show-maximum-output t)

;;
(show-paren-mode 1)


;;非アクティブウィンドウの背景色を設定
(require 'hiwin)
(hiwin-activate)
(set-face-background 'hiwin-face "#3a3939")
