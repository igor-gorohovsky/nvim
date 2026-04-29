vim.keymap.set("x", "<Leader>cc", function()
  require("claude_comments").add()
end, { desc = "Add Claude review comment on selection" })

vim.keymap.set("n", "<Leader>cs", function()
  require("claude_comments").send()
end, { desc = "Send Claude comments via zellij" })

vim.keymap.set("n", "<Leader>cx", function()
  require("claude_comments").clear()
end, { desc = "Clear all Claude comments" })

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    require("claude_comments").peek()
  end,
})
