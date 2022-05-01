(use-package hydra)

(use-package hydra-posframe
  :straight (hydra-posframe :type git :host github :repo "Ladicle/hydra-posframe")
  :hook (after-init . hydra-posframe-mode)
  :custom
  (hydra-posframe-poshandler 'posframe-poshandler-frame-center)
  (hydra-posframe-border-width 2)
  (custom-set-faces
   `(hydra-posframe-border-face ((t (:background ,(doom-color 'bg)))))
   `(hydra-posframe-face ((t (:background "black"))))
   )
  )

(defhydra hydra-buffer
  (:hint nil)
  "

   Buffer
 ---------------------- 
   _s_witch    _k_ill
   _p_revious  _n_ext
"
  ("s" ivy-switch-buffer :exit t)
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
    _s_elect    _a_djust         
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
  ("=" balance-windows    :exit t)
  )

(defalias 'evil-window-map 'hydra-window/body)

;; hydra global menu
(defhydra hydra-global-menu
  (:exit t :hint nil)
  "

 hydra
 ----------------------------------- 
 _a_lpha _b_uffer _c_ounsel
 _r_evert 
 e_v_al  M-_x_    _j_unk    _t_ab   
 max_i_mize
 _w_hich _d_ap
"
  ("a" set-alpha)
  ("b" hydra-buffer/body)
  ("c" hydra-counsel/body)
  ("d" dap-hydra/body)
  ("r" (revert-buffer t t))
  ("v" eval-buffer)
  ("x" (counsel-M-x ""))
  ("j" open-junk-file)
  ("i" toggle-frame-maximized)
  ("w" which-key-mode)
  ("t" tab-bar-switch-to-tab))

(define-key evil-normal-state-map (kbd "SPC") 'hydra-global-menu/body)
(define-key evil-visual-state-map (kbd "SPC") 'hydra-global-menu/body)
