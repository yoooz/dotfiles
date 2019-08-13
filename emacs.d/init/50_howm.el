;; howm
(use-package howm
  :config
  (setq howm-file-name-format "%Y/%m/%Y_%m_%d.txt")
  (setq howm-keyword-file "~/howm/.howm-keys")
  (setq howm-menu-lang 'ja)
  (setq action-lock-no-browser t)
  (defvar howm-view-title-header "# ")
  (defvar datetime-format "%Y-%m-%dT%H:%M:%S")
  (setq howm-template-date-format
        (concat "[" datetime-format "]"))
  (setq howm-keyword-case-fold-search t)
  )
