(use-package hydra)

(use-package hydra-posframe
  :straight (hydra-posframe :type git :host github :repo "Ladicle/hydra-posframe")
  :hook (after-init . hydra-posframe-mode)
  :custom
  (hydra-posframe-poshandler 'posframe-poshandler-frame-center)
  (hydra-posframe-border-width 2)
  (custom-set-faces
   `(hydra-posframe-border-face ((t (:background ,(doom-color 'bg)))))
   `(hydra-posframe-face ((t (:background "black"))))))

(defhydra hydra-global-menu
  (:hint nil)
  "

   Size     Zoom      Frame          Counsel             Other
 ------------------------------------------------------------------------- 
     _k_        _z_      [_i_] select    [_b_] switch buffer    [_A_] alpha
     ↑        ↑      [_d_] delete    [_K_] kill buffer      [_w_] which key
  _h_ ← → _l_            [_s_] swap      [_f_] find file        [_J_] junk file
     ↓        ↓      [_m_] maximize  [_r_] find repository  [_v_] eval buffer
     _j_        _x_                    [_g_] search file      [_V_] revert buffer
                                   [_c_] recent file
  [_F_] fit [_a_] adjust               [_R_] ripgrep
                                   [_e_] M-x
 ------------------------------------------------------------------------- 
                        [_q_] quit  [_<SPC>_] rotate
"
  ;size
  ("k" evil-window-increase-height :color pink)
  ("j" evil-window-decrease-height :color pink)
  ("h" evil-window-decrease-width :color pink)
  ("l" evil-window-increase-width :color pink)
  ("F" balance-windows :exit t :color blue)
  ;zoom
  ("z" text-scale-increase :color pink)
  ("x" text-scale-decrease :color pink)
  ("a" (text-scale-adjust 0) :exit t :color blue)
  ;Frame
  ("i" ace-select-window :exit t :color blue)
  ("d" ace-delete-window :exit t :color blue)
  ("s" ase-swap-window :exit t :color blue)
  ("m" toggle-frame-maximized :exit t :color blue)
  ;counsel
  ("b" ivy-switch-buffer :exit t :color blue)
  ("K" kill-buffer :exit t :color blue)
  ("f" counsel-find-file :exit t :color blue)
  ("r" counsel-ghq :exit t :color blue)
  ("g" counsel-git :exit t :color blue)
  ("c" counsel-recentf :exit t :color blue)
  ("R" counsel-rg :exit t :color blue)
  ("e" (counsel-M-x "") :exit t :color blue)
  ;other
  ("A" set-alpha :exit t :color blue)
  ("w" which-key-mode :exit t :color blue)
  ("J" open-junk-file :exit t :color blue)
  ("v" eval-buffer :exit t :color blue)
  ("V" (revert-buffer t t) :exit t :color blue)

  ("q" () :exit t :color blue)
  ("<SPC>" evil-window-rotate-upwards :color pink))

(define-key evil-normal-state-map (kbd "SPC") 'hydra-global-menu/body)
(define-key evil-visual-state-map (kbd "SPC") 'hydra-global-menu/body)
