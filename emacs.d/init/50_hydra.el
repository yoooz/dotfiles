(use-package hydra)

(use-package hydra-posframe
  :straight (hydra-posframe :type git :host github :repo "Ladicle/hydra-posframe")
  :hook (after-init . hydra-posframe-mode)
  :custom-face
  (hydra-posframe-border-face ((t (:background "CornflowerBlue"))))
  (hydra-posframe-face ((t (:background "SteelBlue4"))))
  :custom
  (hydra-posframe-poshandler 'posframe-poshandler-frame-center)
  (hydra-posframe-border-width 10)
  )

(defhydra hydra-git
  (:hint nil)
  "
  Git
----------------------
  ma_g_it
  _n_ext      _p_revious
  _s_tage     _r_evert   p_o_pup
"
  ("g" magit-status :exit t)
  ("s" git-gutter:stage-hunk)
  ("p" git-gutter:previous-hunk)
  ("n" git-gutter:next-hunk)
  ("r" git-gutter:revert-hunk)
  ("o" git-gutter:popup-hunk))

(defhydra hydra-buffer
  (:hint nil)
  "
  Buffer
----------------------
  _s_witch    _k_ill
  _p_revious  _n_ext
"
  ("s" counsel-switch-buffer :exit t)
  ("k" kill-buffer :exit t)
  ("p" iflipb-previous-buffer)
  ("n" iflipb-next-buffer))

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
   s_w_ap
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
  ("a" (text-scale-adjust 0))
  ("s" ace-select-window  :exit t)
  ("d" ace-delete-window  :exit t)
  ("w" ace-swap-window    :exit t)
  ("-" evil-window-split  :exit t)
  ("/" evil-window-vsplit :exit t)
  ("z" zoom-mode          :exit t)
  ("=" balance-windows    :exit t)
  )

(defalias 'evil-window-map 'hydra-window/body)

(defhydra hydra-trello
  (:exit t :hint nil)
  "
    Trello
----------------------------------------
    _o_pen trello buffer
    _i_nstall board meta data
    _d_ownload from trello
    _u_pdate to trello
    _s_ync card
    _a_dd comment
    _j_ump to board
----------------------------------------

"
  ("o" (find-file "~/howm/trello.org"))
  ("i" org-trello-install-board-metadata)
  ("d" (org-trello-sync-buffer "o"))
  ("u" org-trello-sync-buffer)
  ("s" org-trello-sync-card)
  ("a" org-trello-add-card-comment)
  ("j" org-trello-jump-to-trello-board))

;; hydra global menu
(defhydra hydra-global-menu
  (:exit t :hint nil)
  "
hydra
-----------------------------------
_a_lpha _b_uffer _c_ounsel _f_old
_g_it   _h_owm   _r_evert  _s_udo
e_v_al   M-_x_   _j_unk    _n_eotree
t_l_lero       max_i_mize
_w_hich
"
  ("a" set-alpha)
  ("b" hydra-buffer/body)
  ("c" hydra-counsel/body)
  ("f" hs-toggle-hiding)
  ("g" hydra-git/body)
  ("h" hydra-howm/body)
  ("r" (revert-buffer t t))
  ("s" sudo-edit)
  ("v" eval-buffer)
  ("x" (counsel-M-x ""))
  ("j" open-junk-file)
  ("n" neotree-toggle)
  ("l" hydra-trello/body)
  ("i" toggle-frame-maximized)
  ("w" which-key-mode))

(define-key evil-normal-state-map (kbd "SPC") 'hydra-global-menu/body)
(define-key evil-visual-state-map (kbd "SPC") 'hydra-global-menu/body)
(eval-after-load 'magit
  '(progn
     (define-key magit-mode-map (kbd "SPC") 'hydra-global-menu/body)))
