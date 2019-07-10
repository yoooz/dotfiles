(use-package twittering-mode
  :config
  (setq twittering-icon-mode t)
  )

(setq newsticker-url-list
      '(
        ("Qiita Emacs" "http://qiita.com/tags/Emacs/feed.atom")
        ("Qiita Kotlin" "http://qiita.com/tags/Kotlin/feed.atom")
        ("Qiita Swift" "http://qiita.com/tags/Swift/feed.atom")
        ("Qiita Android" "http://qiita.com/tags/Android/feed.atom")
        ("Qiita iOS" "http://qiita.com/tags/iOS/feed.atom")
        ("Qiita tmux" "http://qiita.com/tags/tmux/feed.atom")
        ("Qiita zsh" "http://qiita.com/tags/zsh/feed.atom")
        ("Qiita elisp" "http://qiita.com/tags/elisp/feed.atom")

        ("Github Trending emacs-lisp" "https://mshibanami.github.io/GitHubTrendingRSS/daily/emacs-lisp.xml")
        ("Github Trending kotlin" "https://mshibanami.github.io/GitHubTrendingRSS/daily/kotlin.xml")

        ("Life Hacker" "http://feeds.lifehacker.jp/rss/lifehacker/index.xml")
        ("GIGAZINE" "http://gigazine.net/news/rss_2.0/")
        ("ビジネスジャーナル" "http://biz-journal.jp/index.xml")
        ("朝日新聞デジタル" "http://www3.asahi.com/rss/index.rdf")
        ("ギズモード・ジャパン" "http://www.gizmodo.jp/atom.xml")
        ("techcrunch" "https://jp.techcrunch.com/feed/")
        ("gori.me" "https://gori.me/feed")

        ("planet ubuntu" "http://planet.ubuntu.com/rss20.xml")
        ("ubuntu blog" "https://admin.insights.ubuntu.com/feed")
        )
      )
