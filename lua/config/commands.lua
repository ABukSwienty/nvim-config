local command = vim.api.nvim_create_user_command

-- ts_ls needs its own command; other servers use the standard code action
-- (apply = true skips the picker when there's one match)
command("OrganizeImports", function()
  local ts = vim.lsp.get_clients({ bufnr = 0, name = "ts_ls" })[1]
  if ts then
    ts:exec_cmd({
      title = "Organize imports",
      command = "_typescript.organizeImports",
      arguments = { vim.api.nvim_buf_get_name(0) },
    })
    return
  end
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