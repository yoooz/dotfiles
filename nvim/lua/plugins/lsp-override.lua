return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        denols = {
          mason = false,
        },
      },
      -- Inlay Hintsをデフォルトで無効にする
      inlay_hints = {
        enabled = false,
      },
    },
  },
}
