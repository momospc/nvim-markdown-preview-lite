local M = {}

local preview_buf = nil
local preview_win = nil

local function render_markdown()
  local file = vim.fn.expand("%:p")
  if file == "" then return end

  local cmd = "pandoc " .. vim.fn.shellescape(file)
  local output = vim.fn.system(cmd)

  if not preview_buf or not vim.api.nvim_buf_is_valid(preview_buf) then
    preview_buf = vim.api.nvim_create_buf(false, true)
  end

  vim.api.nvim_buf_set_lines(preview_buf, 0, -1, false, vim.split(output, "\n"))
  vim.api.nvim_buf_set_option(preview_buf, "filetype", "html")
end

function M.open_preview()
  if preview_win and vim.api.nvim_win_is_valid(preview_win) then
    return
  end

  vim.cmd("vsplit")
  preview_win = vim.api.nvim_get_current_win()
  preview_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(preview_win, preview_buf)

  render_markdown()
end

function M.update_preview()
  if preview_buf and vim.api.nvim_buf_is_valid(preview_buf) then
    render_markdown()
  end
end

return M
