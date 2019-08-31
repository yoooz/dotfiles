(use-package request)

;; Item display function
(defun dashboard-qiita-insert-list (list-display-name list)
  "Render LIST-DISPLAY-NAME and items of LIST."
  (dashboard-insert-heading list-display-name)
  (mapc (lambda (el)
          (insert "\n    ")
          (widget-create 'push-button
                         :action `(lambda (&rest ignore)
                                    (browse-url ,(cdr (assoc 'url el))))
                         :mouse-face 'highlight
                         :follow-link "\C-m"
                         :button-prefix ""
                         :button-suffix ""
                         :format "%[%t%]"
                         (decode-coding-string (cdr (assoc 'title el)) 'utf-8))) list))

;; Function to get and display articles
(defun dashboard-qiita-insert (list-size)
  "Add the list of LIST-SIZE items from qiita."
  (request
   ;; (format "https://qiita.com/api/v2/items?page=1&per_page=%s" list-size)
   (format "https://qiita.com/api/v2/tags/emacs/items?page=1&per_page=%s" list-size)
   :sync t
   :parser 'json-read
   :success (cl-function
             (lambda (&key data &allow-other-keys)
               (dashboard-qiita-insert-list "Qiita(emacs-tag):" data)))))

