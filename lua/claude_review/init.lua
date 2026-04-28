local M = {}

local state = nil

local pause_file = vim.fn.expand("~/.cache/claude-review-paused")

local group = vim.api.nvim_create_augroup("ClaudeReview", { clear = true })

local function write_fifo(line)
  if not state then return end
  local fifo = state.fifo
  pcall(vim.fn.writefile, { line }, fifo)
end

local function close_review()
  local s = state
  state = nil
  if s and s.tab and vim.api.nvim_tabpage_is_valid(s.tab) then
    local nr = vim.api.nvim_tabpage_get_number(s.tab)
    pcall(vim.cmd, nr .. "tabclose")
  end
end

local function decide(line)
  write_fifo(line)
  close_review()
end

function M.approve()
  decide("allow")
end

function M.decline_quick()
  decide("deny:declined")
end

function M.decline_with_comment()
  vim.ui.input({ prompt = "Decline reason: " }, function(input)
    if input == nil then return end
    if input == "" then input = "declined" end
    decide("deny:" .. input)
  end)
end

function M.approve_with_note()
  vim.ui.input({ prompt = "Note for later: " }, function(input)
    if input == nil then return end
    if input ~= "" and state and state.notes_file then
      local lines = {}
      if vim.uv.fs_stat(state.notes_file) then
        lines = vim.fn.readfile(state.notes_file)
      end
      table.insert(lines, "- " .. input)
      pcall(vim.fn.writefile, lines, state.notes_file)
    end
    decide("allow")
  end)
end

function M.start(opts)
  if state then
    decide("deny:concurrent-review")
  end

  state = {
    fifo = opts.fifo,
    notes_file = opts.notes_file,
  }

  vim.cmd("tabnew")
  state.tab = vim.api.nvim_get_current_tabpage()

  vim.cmd("edit " .. vim.fn.fnameescape(opts.file))
  vim.cmd("vert diffsplit " .. vim.fn.fnameescape(opts.pending))

  local pending_buf = vim.api.nvim_get_current_buf()

  local map = function(lhs, fn, desc)
    vim.keymap.set("n", lhs, fn, {
      buffer = pending_buf,
      silent = true,
      desc = desc,
    })
  end

  map("<Leader>ca", M.approve, "Approve change")
  map("<Leader>cd", M.decline_quick, "Decline (quick)")
  map("<Leader>cD", M.decline_with_comment, "Decline with comment")
  map("<Leader>cn", M.approve_with_note, "Approve + note for later")
end

function M.toggle_pause()
  if vim.uv.fs_stat(pause_file) then
    vim.uv.fs_unlink(pause_file)
    vim.notify("Claude review: enabled")
  else
    vim.fn.mkdir(vim.fn.fnamemodify(pause_file, ":h"), "p")
    vim.fn.writefile({ "" }, pause_file)
    vim.notify("Claude review: paused")
    if state then
      decide("allow")
    end
  end
end

vim.api.nvim_create_autocmd("TabClosed", {
  group = group,
  callback = function()
    if state then
      pcall(vim.fn.writefile, { "deny:closed-without-decision" }, state.fifo)
      state = nil
    end
  end,
})

return M
