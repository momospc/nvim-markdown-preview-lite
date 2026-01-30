local preview = require("markdown_preview.preview")

local M = {}

function M.setup()
  vim.api.nvim_create_user_command("MarkdownPreview", function()
    preview.open_preview()
  end, {})

  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.md",
    callback = function()
      preview.update_preview()
    end,
  })
end

return M
