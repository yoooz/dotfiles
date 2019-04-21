;; howm
(use-package howm)
(setq howm-file-name-format "%Y/%m/%Y_%m_%d.txt")
(setq howm-keyword-file "~/howm/.howm-keys")
(setq howm-menu-lang 'ja)
(setq action-lock-no-browser t)
(defvar howm-view-title-header "# ")
(defvar datetime-format "%Y-%m-%dT%H:%M:%S")
(setq howm-template-date-format
      (concat "[" datetime-format "]"))
(setq howm-keyword-case-fold-search t)

(defhydra hydra-howm(:exit t)
  "howm"
  ("e" howm-remember "remember")
  ("c" howm-create "create")
  ("a" howm-list-all "list-all")
  (":" howm-find-yesterday "yesterday")
  ("." howm-find-today "today"))

(global-set-key (kbd "C-c h") #'hydra-howm/body)
