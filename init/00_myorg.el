;; org
(setq org-agenda-files '("~/config/org_sample/todo.org"
                         "~/config/org_sample/list.org"))

(setq work-directory "~/config/org_sample/")
(setq todofile (concat work-directory "todo.org"))
(setq listfile (concat work-directory "list.org"))
(setq notesfile (concat work-directory "notes.org"))

(setq org-capture-templates
      '(
        ;; todo
        ("t" "todo" entry (file+headline todofile "Todos")
         "** TODO %? \n")
        ;; list
        ("l" "list" entry (file+headline listfile "Lists")
         "** TODO %? \n")
        ;; notes
        ("n" "Note" entry (file+headline notesfile "Notes")
         "* %?\nEntered on %U\n %i\n %a")
        )
      )

(setq org-todo-keywords
      '((sequence "TODO(t)" "SOMDEDAY(s)" "WAITING(w)" "|" "DONE(d)")))
