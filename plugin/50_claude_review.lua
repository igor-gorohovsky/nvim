local session = vim.env.ZELLIJ_SESSION_NAME
if session and session ~= "" then
  local sock = "/tmp/nvim-claude-" .. session .. ".sock"
  if vim.uv.fs_stat(sock) then
    pcall(vim.uv.fs_unlink, sock)
  end
  pcall(vim.fn.serverstart, sock)
end

vim.keymap.set("n", "<Leader>cp", function()
  require("claude_review").toggle_pause()
end, { desc = "Toggle Claude review pause" })
