local plugin_dir = vim.fn.expand('~/projects/agent-review.nvim')
if not vim.uv.fs_stat(plugin_dir) then
  return
end

vim.opt.runtimepath:prepend(plugin_dir)

require('agent_review').setup({
  agent_name = 'Claude',
  keymaps = {
    enabled = true,
    pause = '<Leader>cp',
    approve = '<Leader>ca',
    decline_quick = '<Leader>cd',
    decline_with_comment = '<Leader>cD',
    approve_with_note = '<Leader>cn',
    comment_add = '<Leader>cc',
    comment_send = '<Leader>cs',
    comment_clear = '<Leader>cx',
  },
  transport = {
    type = 'zellij',
    focus_direction = 'right',
    fallback = 'clipboard',
  },
})
