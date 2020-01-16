(use-package hydra)

;; hydra global menu
(defhydra hydra-global-menu
  (:exit t :hint nil)
  "
hydra
--------------------------------------
_a_lpha _b_uffer _c_ursors _g_it-gutter 
_h_owm  _m_agit  _s_earch  _t_ab
_w_indow
"
  ("a" set-alpha)
  ("b" hydra-buffer/body)
  ("c" hydra-multiple-cursors/body)
  ("g" hydra-git-gutter/body)
  ("h" hydra-howm/body)
  ("m" magit-status)
  ("s" hydra-search/body)
  ("t" hydra-tab/body)
  ("w" hydra-window/body))

(define-key evil-normal-state-map (kbd "SPC") 'hydra-global-menu/body)
(define-key magit-mode-map (kbd "SPC") 'hydra-global-menu/body)

;; hydra
(defhydra hydra-git-gutter nil
  "git hunk"
  ("p" git-gutter:previous-hunk "previous")
  ("n" git-gutter:next-hunk     "next")
  ("s" git-gutter:stage-hunk    "stage")
  ("r" git-gutter:revert-hunk   "revert"))

(defhydra hydra-howm
  (:exit t)
  "howm"
  ("r" howm-remember       "remember")
  ("c" howm-create         "create")
  ("l" howm-list-all       "list-all")
  ("y" howm-find-yesterday "yesterday")
  ("t" howm-find-today     "today")
  ("m" howm-menu           "menu")
  ("d" howm-insert-date    "date"))

(defhydra hydra-window
  (:exit t)
  "window"
  ("s" ace-select-window  "select")
  ("d" ace-delete-window  "delete")
  ("o" other-window       "other")
  ("v" split-window-below "vertical")
  ("h" split-window-right "horizontal"))

(defhydra hydra-buffer
  (:exit t)
  "buffer"
  ("s" ivy-switch-buffer "switch")
  ("k" kill-buffer       "kill"))

(defhydra hydra-tab
  (:exit t)
  "tab"
  ("c" elscreen-create   "create")
  ("g" elscreen-goto     "goto")
  ("n" elscreen-next     "next")
  ("p" elscreen-previous "previous")
  ("k" elscreen-kill     "kill"))

(defhydra hydra-search
  (:exit t)
  "search"
  ("x" counsel-M-x       "M-x")
  ("f" counsel-find-file "find-file")
  ("g" counsel-git       "git")
  ("p" counsel-ghq       "project")
  ("r" counsel-rg        "ripgrep"))

(defhydra hydra-multiple-cursors
  (:hint nil)
    "
 Up^^             Down^^           Miscellaneous 
------------------------------------------------------------------
 [_p_]   Next     [_n_]   Next     [_l_] Edit lines  [_0_] Insert numbers
 [_P_]   Skip     [_N_]   Skip     [_a_] Mark all    [_A_] Insert letters
 [_M-p_] Unmark   [_M-n_] Unmark   [_s_] Search
 [_q_] Quit"
  ("l" mc/edit-lines :exit t)
  ("a" mc/mark-all-like-this :exit t)
  ("n" mc/mark-next-like-this)
  ("N" mc/skip-to-next-like-this)
  ("M-n" mc/unmark-next-like-this)
  ("p" mc/mark-previous-like-this)
  ("P" mc/skip-to-previous-like-this)
  ("M-p" mc/unmark-previous-like-this)
  ("s" mc/mark-all-in-region-regexp :exit t)
  ("0" mc/insert-numbers :exit t)
  ("A" mc/insert-letters :exit t)
  ("q" nil))
