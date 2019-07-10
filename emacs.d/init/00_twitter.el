(use-package twittering-mode
  :config
  (setq twittering-icon-mode t)
  )

(setq newsticker-url-list
      '(
        ("Qiita Emacs" "http://qiita.com/tags/Emacs/feed.atom"))) 


(use-package elfeed
  :config
  (setq elfeed-feeds
        '("http://qiita.com/tags/Emacs/feed.atom"
          "http://qiita.com/tags/Kotlin/feed.atom"
          "http://qiita.com/tags/Swift/feed.atom"
          "http://qiita.com/tags/Terminal/feed.atom"
          "http://qiita.com/tags/tmux/feed.atom")
        )
  )
