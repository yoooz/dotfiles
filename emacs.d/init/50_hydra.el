(use-package hydra)

(use-package hydra-posframe
  :straight (hydra-posframe :type git :host github :repo "Ladicle/hydra-posframe")
  :hook (after-init . hydra-posframe-mode)
  :custom-face
  (hydra-posframe-border-face ((t (:background "CornflowerBlue"))))
  (hydra-posframe-face ((t (:background "#232533"))))
  :custom
  (hydra-posframe-poshandler 'posframe-poshandler-frame-center)
  (hydra-posframe-border-width 10)
  )

;; hydra global menu
(defhydra hydra-global-menu
  (:exit t :hint nil)
  "
hydra
-----------------------------------
_a_lpha _b_uffer _c_ounsel _f_old
_g_it   _h_owm   _m_c      _r_evert  
_t_ab   M-_x_    e_v_al

codic
-----------------------------------
_e_ -> j         _j_ -> e
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
  ("v" eval-buffer)
  ("e" codic)
  ("j" codic-translate))

(define-key evil-normal-state-map (kbd "SPC") 'hydra-global-menu/body)
(define-key magit-mode-map (kbd "SPC") 'hydra-global-menu/body)

(defhydra hydra-buffer
  (:exit t :hint nil)
  "
  Buffer
----------------------
  _s_witch    _k_ill
"
  ("s" ivy-switch-buffer)
  ("k" kill-buffer))

(defhydra hydra-counsel
  (:exit t :hint nil)
  "
  Counsel
----------------------------
  _f_ind-file    _s_wiper
  _g_it          g_h_q
  _r_ipgrep      re_c_entf
"
  ("f" counsel-find-file)
  ("s" swiper)
  ("g" counsel-git)
  ("h" counsel-ghq)
  ("r" counsel-rg)
  ("c" counsel-recentf))

(defhydra hydra-howm
  (:exit t :hint nil)
  "
  Howm
---------------------------
  _r_emember    _c_reate
  _l_ist-all    _y_esterday
  _t_oday       _m_enu
  howm-insert-_d_ate
"
  ("r" howm-remember)
  ("c" howm-create)
  ("l" howm-list-all)
  ("y" howm-find-yesterday)
  ("t" howm-find-today)
  ("m" howm-menu)
  ("d" howm-insert-date))

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
  (:exit t :hint nil)
  "
  Tab
----------------------
  _c_reate    _g_oto
  _n_ext      _p_revious
  _k_ill
"
  ("c" elscreen-create)
  ("g" elscreen-goto)
  ("n" elscreen-next)
  ("p" elscreen-previous)
  ("k" elscreen-kill))

(defhydra hydra-window
  (:hint nil)
  "
    Select    Zoom    Split    Frame
----------------------------------------
      k       _i_n        -         K
      ↑        ↑        ↑         ↑
  h ←   → l                   H ←   → L
      ↓        ↓        ↓         ↓
      j       _o_ut       /         J
----------------------------------------
   _s_elect    _a_djust           _z_oom-mode
   _d_elete                     _=_balance
"
  ("K" evil-window-increase-height)
  ("J" evil-window-decrease-height)
  ("H" evil-window-decrease-width)
  ("L" evil-window-increase-width)
  ("k" evil-window-up     :exit t)
  ("j" evil-window-down   :exit t)
  ("h" evil-window-left   :exit t)
  ("l" evil-window-right  :exit t)
  ("i" text-scale-increase)
  ("o" text-scale-decrease)
  ("a" text-scale-adjust)
  ("s" ace-select-window  :exit t)
  ("d" ace-delete-window  :exit t)
  ("-" evil-window-split  :exit t)
  ("/" evil-window-vsplit :exit t)
  ("z" zoom-mode          :exit t)
  ("=" balance-windows    :exit t)
  )

(defalias 'evil-window-map 'hydra-window/body)
