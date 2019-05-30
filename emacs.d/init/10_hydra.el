(use-package hydra)

;; hydra global menu
(defhydra hydra-global-menu
  (:exit t
         :hint nil)
  "
hydra
----------------------------------------------------------
[_a_]: avy [_b_]: markdown [_c_]: counsel [_d_]: git-gutter 
[_g_]: magit [_h_]: howm [_l_]: goto-line [_m_]: move 
[_s_]: mcurosr [_y_]: yank "
  ("d" hydra-git-gutter/body)
  ("y" hydra-yank-pop/body)
  ("m" hydra-move/body)
  ("l" hydra-goto-line/body)
  ("a" hydra-avy/body)
  ("b" dh-hydra-markdown-mode/body)
  ("s" hydra-multiple-cursors/body)
  ("h" hydra-howm/body)
  ("g" hydra-magit/body)
  ("c" hydra-counsel/body))

(global-set-key (kbd "C-t") 'hydra-global-menu/body)

;; hydra
;; git-gutter hydra
(defhydra hydra-git-gutter nil
  "git hunk"
  ("p" git-gutter:previous-hunk "previous")
  ("n" git-gutter:next-hunk "next")
  ("s" git-gutter:stage-hunk "stage")
  ("r" git-gutter:revert-hunk "revert"))

(defhydra hydra-yank-pop()
  "yank"
  ("C-y" yank nil)
  ("M-y" yank-pop nil)
  ("y" (yank-pop 1) "next")
  ("Y" (yank-pop -1) "prev")
  ("l" counsel-yank-pop))

;; Movement
(defhydra hydra-move
  (:body-pre (next-line)
             :hint nil)
  "
move
----------------------------------------------------------
_n_ext-line _p_revious-line _f_orward-char _b_ackward-char
_a_: beginning-of-line _e_: end-of-line 
_v_: scroll-down _V_: scroll-up"
  ("n" next-line)
  ("p" previous-line)
  ("f" forward-char)
  ("b" backward-char)
  ("a" beginning-of-line)
  ("e" move-end-of-line)
  ("v" scroll-up-command)
  ("V" scroll-down-command))

;; goto line
(defhydra hydra-goto-line (goto-map ""
                                    :post (linum-mode -1))
  "goto-line"
  ("g" goto-line "go")
  ("m" set-mark-command "mark" :bind nil)
  ("q" nil "quit"))

(defhydra hydra-avy (:exit t :hint nil)
    "
 Line^^       Region^^        Goto
----------------------------------------------------------
 [_y_] yank   [_Y_] yank      [_c_] timed char  [_C_] char
 [_m_] move   [_M_] move      [_w_] word        [_W_] any word
 [_k_] kill   [_K_] kill      [_l_] line        [_L_] end of line"
    ("c" avy-goto-char-timer)
    ("C" avy-goto-char)
    ("w" avy-goto-word-1)
    ("W" avy-goto-word-0)
    ("l" avy-goto-line)
    ("L" avy-goto-end-of-line)
    ("m" avy-move-line)
    ("M" avy-move-region)
    ("k" avy-kill-whole-line)
    ("K" avy-kill-region)
    ("y" avy-copy-line)
    ("Y" avy-copy-region))

(defhydra dh-hydra-markdown-mode (:hint nil)
    "
Formatting        C-c C-s    _s_: bold          _e_: italic     _b_: blockquote   _p_: pre-formatted    _c_: code

Headings          C-c C-t    _h_: automatic     _1_: h1         _2_: h2           _3_: h3               _4_: h4

Lists             C-c C-x    _m_: insert item   

Demote/Promote    C-c C-x    _l_: promote       _r_: demote     _u_: move up      _d_: move down

Links, footnotes  C-c C-a    _L_: link          _U_: uri        _F_: footnote     _W_: wiki-link      _R_: reference
 
"
    ("s" markdown-insert-bold)
    ("e" markdown-insert-italic)
    ("b" markdown-insert-blockquote :color blue)
    ("p" markdown-insert-pre :color blue)
    ("c" markdown-insert-code)

    ("h" markdown-insert-header-dwim)
    ("1" markdown-insert-header-atx-1)
    ("2" markdown-insert-header-atx-2)
    ("3" markdown-insert-header-atx-3)
    ("4" markdown-insert-header-atx-4)

    ("m" markdown-insert-list-item)

    ("l" markdown-promote)
    ("r" markdown-demote)
    ("d" markdown-move-down)
    ("u" markdown-move-up)

    ("L" markdown-insert-link :color blue)
    ("U" markdown-insert-uri :color blue)
    ("F" markdown-insert-footnote :color blue)
    ("W" markdown-insert-wiki-link :color blue)
    ("R" markdown-insert-reference-link-dwim :color blue))

(defhydra hydra-multiple-cursors (:hint nil)
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

(defhydra hydra-howm(:exit t)
  "howm"
  ("r" howm-remember "remember")
  ("c" howm-create "create")
  ("l" howm-list-all "list-all")
  ("y" howm-find-yesterday "yesterday")
  ("t" howm-find-today "today")
  ("m" howm-menu "menu")
  ("d" howm-insert-date))

(defhydra hydra-magit(:exit t)
  "magit"
  ("s" magit-status "status")
  ("b" magit-blame-addition "blame")
  ("l" magit-log-current "log")
  ("c" magit-commit-create "commit")
  ("p" magit-push-current-to-upstream "push"))

(defhydra hydra-counsel(:exit t)
  "counsel"
  ("g" counsel-git "git")
  ("r" counsel-rg "rg")
  ("s" counsel-switch-buffer "switch-buffer"))
