-- Can be used when null-ls is no longer available
require("lint").linters_by_ft = {
  javascript = {"eslint"},
  typescript = {"eslint"},
}

vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    require("lint").try_lint()
  end,
})
