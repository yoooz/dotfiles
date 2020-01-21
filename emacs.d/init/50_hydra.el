(use-package hydra)

(use-package hydra-posframe
  :straight (hydra-posframe :type git :host github :repo "Ladicle/hydra-posframe")
  :hook (after-init . hydra-posframe-enable))

;; hydra global menu
(defhydra hydra-global-menu
  (:exit t :hint nil)
  "
hydra
-----------------------------------
_a_lpha _b_uffer _c_ounsel _f_old
_g_it   _h_owm   _m_c      _r_evert  
_t_ab   M-_x_    _z_oom   

codic
-----------------------------------
_e_ -> j         _j_ -> e

window
-----------------------------------
_s_elect         _d_elete
"
  ("a" set-alpha)
  ("b" hydra-buffer/body)
  ("c" hydra-counsel/body)
  ("f" hs-toggle-hiding)
  ("g" magit-status)
  ("h" hydra-howm/body)
  ("m" hydra-multiple-cursors/body)
  ("r" revert-buffer)
  ("t" hydra-tab/body)
  ("x" counsel-M-x)
  ("z" zoom)
  ("e" codic)
  ("j" codic-translate)
  ("s" ace-select-window)
  ("d" ace-delete-window))

(define-key evil-normal-state-map (kbd "SPC") 'hydra-global-menu/body)
(define-key magit-mode-map (kbd "SPC") 'hydra-global-menu/body)

(defhydra hydra-buffer
  (:exit t)
  "buffer"
  ("s" ivy-switch-buffer "switch")
  ("k" kill-buffer       "kill"))

(defhydra hydra-counsel
  (:exit t)
  "search"
  ("f" counsel-find-file "find-file")
  ("g" counsel-git       "git")
  ("p" counsel-ghq       "project")
  ("r" counsel-rg        "ripgrep"))

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

(defhydra hydra-tab
  (:exit t)
  "tab"
  ("c" elscreen-create   "create")
  ("g" elscreen-goto     "goto")
  ("n" elscreen-next     "next")
  ("p" elscreen-previous "previous")
  ("k" elscreen-kill     "kill"))
