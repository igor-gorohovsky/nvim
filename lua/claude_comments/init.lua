local M = {}

local ns = vim.api.nvim_create_namespace("claude_comments")
local hl_group = "ClaudeComment"
local group = vim.api.nvim_create_augroup("ClaudeComments", { clear = true })

vim.api.nvim_set_hl(0, hl_group, { bg = "#3a2e2e", default = true })

local comments = {}

local function selection_lines()
  local s = vim.fn.line("v")
  local e = vim.fn.line(".")
  if s > e then s, e = e, s end
  return s - 1, e - 1
end

local function exit_visual()
  local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
  vim.api.nvim_feedkeys(esc, "n", false)
end

function M.add()
  local s_row, e_row = selection_lines()
  local bufnr = vim.api.nvim_get_current_buf()
  exit_visual()

  vim.schedule(function()
    vim.ui.input({ prompt = "Comment for Claude: " }, function(input)
      if not input or input == "" then return end

      comments[bufnr] = comments[bufnr] or {}
      local overlapping = vim.api.nvim_buf_get_extmarks(
        bufnr, ns, { s_row, 0 }, { e_row, -1 },
        { details = true, overlap = true }
      )
      for _, m in ipairs(overlapping) do
        local id = m[1]
        if comments[bufnr][id] then
          vim.api.nvim_buf_del_extmark(bufnr, ns, id)
          comments[bufnr][id] = nil
        end
      end

      local last_line = vim.api.nvim_buf_get_lines(bufnr, e_row, e_row + 1, false)[1] or ""
      local id = vim.api.nvim_buf_set_extmark(bufnr, ns, s_row, 0, {
        end_row = e_row,
        end_col = #last_line,
        hl_group = hl_group,
        hl_eol = true,
      })
      comments[bufnr][id] = input
    end)
  end)
end

function M.peek()
  local bufnr = vim.api.nvim_get_current_buf()
  local mapping = comments[bufnr]
  if not mapping then return end
  local row = vim.fn.line(".") - 1
  local marks = vim.api.nvim_buf_get_extmarks(bufnr, ns, 0, -1, { details = true })
  for _, m in ipairs(marks) do
    local id, mr, _, det = m[1], m[2], m[3], m[4]
    local er = (det and det.end_row) or mr
    if row >= mr and row <= er and mapping[id] then
      vim.lsp.util.open_floating_preview({ "Claude comment:", mapping[id] }, "markdown", {
        border = "rounded",
        focus = false,
        focusable = false,
        close_events = { "CursorMoved", "CursorMovedI", "BufLeave", "InsertEnter" },
      })
      return
    end
  end
end

local function collect(bufnrs, path_overrides)
  local filter
  if bufnrs then
    filter = {}
    for _, b in ipairs(bufnrs) do filter[b] = true end
  end
  local items = {}
  for bufnr, mapping in pairs(comments) do
    if (not filter or filter[bufnr])
      and vim.api.nvim_buf_is_valid(bufnr)
      and vim.api.nvim_buf_is_loaded(bufnr)
    then
      local rel = path_overrides and path_overrides[bufnr]
      if not rel then
        local fname = vim.api.nvim_buf_get_name(bufnr)
        rel = vim.fn.fnamemodify(fname, ":.")
        if rel == "" then rel = "[no name]" end
      end
      for id, text in pairs(mapping) do
        local pos = vim.api.nvim_buf_get_extmark_by_id(bufnr, ns, id, { details = true })
        if pos and pos[1] then
          local sr = pos[1]
          local er = (pos[3] and pos[3].end_row) or sr
          local snippet = vim.api.nvim_buf_get_lines(bufnr, sr, er + 1, false)
          table.insert(items, {
            file = rel,
            start_line = sr + 1,
            end_line = er + 1,
            snippet = snippet,
            text = text,
          })
        end
      end
    end
  end
  table.sort(items, function(a, b)
    if a.file ~= b.file then return a.file < b.file end
    return a.start_line < b.start_line
  end)
  return items
end

local function format_lines(items)
  local lines = {}
  for _, item in ipairs(items) do
    table.insert(lines, string.format("%s:%d-%d", item.file, item.start_line, item.end_line))
    for _, l in ipairs(item.snippet) do
      table.insert(lines, "> " .. l)
    end
    table.insert(lines, "comment: " .. item.text)
    table.insert(lines, "")
  end
  return lines
end

local function format(items)
  return table.concat(format_lines(items), "\n")
end

function M.send()
  local ok, review = pcall(require, "claude_review")
  if ok and review.is_active and review.is_active() then
    vim.notify("Review in progress: comments will be sent with approve/decline", vim.log.levels.INFO)
    return
  end

  local items = collect()
  if #items == 0 then
    vim.notify("No Claude comments to send", vim.log.levels.INFO)
    return
  end
  local body = format(items)
  local payload = "\27[200~" .. body .. "\27[201~"

  local r1 = vim.system({ "zellij", "action", "move-focus", "right" }):wait()
  if r1.code ~= 0 then
    vim.notify("zellij move-focus failed: " .. (r1.stderr or ""), vim.log.levels.ERROR)
    return
  end
  local r2 = vim.system({ "zellij", "action", "write-chars", payload }):wait()
  if r2.code ~= 0 then
    vim.notify("zellij write-chars failed: " .. (r2.stderr or ""), vim.log.levels.ERROR)
    return
  end

  M.clear()
  vim.notify(string.format("Sent %d Claude comment(s)", #items))
end

function M.take_for_buffers(bufnrs, path_overrides)
  local items = collect(bufnrs, path_overrides)
  if #items == 0 then return nil end
  local lines = format_lines(items)
  M.clear(bufnrs)
  return lines
end

function M.clear(bufnrs)
  if bufnrs then
    for _, bufnr in ipairs(bufnrs) do
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
      end
      comments[bufnr] = nil
    end
    return
  end
  for bufnr, _ in pairs(comments) do
    if vim.api.nvim_buf_is_valid(bufnr) then
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
    end
  end
  comments = {}
end

vim.api.nvim_create_autocmd("BufWipeout", {
  group = group,
  callback = function(args)
    comments[args.buf] = nil
  end,
})

return M
