local command = vim.api.nvim_create_user_command

-- Runs the LSP's organize-imports action; apply = true skips the picker when there's one match
command("OrganizeImports", function()
  vim.lsp.buf.code_action({
    context = { only = { "source.organizeImports" }, diagnostics = {} },
    apply = true,
  })
end, { desc = "Organize imports" })

-- Copy the current file's path to the system clipboard (+ register)
local function copy_path(modifier)
  local path = vim.fn.expand("%" .. modifier)
  if path == "" then
    vim.notify("Buffer has no file", vim.log.levels.WARN)
    return
  end
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end

command("CopyPath", function() copy_path(":.") end, { desc = "Copy file path relative to cwd" })
command("CopyAbsPath", function() copy_path(":p") end, { desc = "Copy absolute file path" })
