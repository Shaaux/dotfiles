return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      -- jsonc parser was removed upstream; use json parser for jsonc files
      vim.treesitter.language.register("json", "jsonc")
    end,
    opts = {
      -- Install parsers into the config dir, which is always in runtimepath
      parser_install_dir = vim.fn.stdpath("config"),
      ignore_install = { "jsonc" },
      ensure_installed = {
        "norg",
        "svelte",
        "typst",
        "vue",
        "xml",
      },
    },
  },
}
