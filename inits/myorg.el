;; org
(setq org-agenda-files '("~/config/org_sample/todo.org"
                         "~/config/org_sample/list.org"))

(setq work-directory "~/config/org_sample/")
(setq todofile (concat work-directory "todo.org"))
(setq listfile (concat work-directory "list.org"))

(setq org-capture-templates
      '(
        ;; todo
        ("t" "todo" entry (file+headline todofile "Todos")
         "** TODO %? \n")
        ;; list
        ("l" "list" entry (file+headline listfile "Lists")
         "** TODO %? \n")
        )
      )
