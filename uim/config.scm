;; SSH terminals use the existing Mozc server via uim 2.0.0's helper.
(require-module "mozc")
(define default-im-name 'mozc)
(define mozc-helper-command
  (string-append (getenv "HOME") "/.local/opt/uim/bin/uim-mozc-helper"))
(define mozc-emacs-helper-command "")

;; Ctrl+Space is reserved for switching keyboard languages on iPadOS.
(define-key generic-on-key? '("<Control>]"))
(define-key generic-off-key? '("<Control>]"))
