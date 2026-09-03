return {
  "folke/snacks.nvim",
  opts = {
    -- <leader>gB / <leader>gY でブランチ名ではなくコミットハッシュ付きの
    -- permalink を開く（Slack 等でコードプレビューが展開されるようにするため）
    gitbrowse = { what = "permalink" },
  },
}
