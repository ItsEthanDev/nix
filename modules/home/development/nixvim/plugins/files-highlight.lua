local ignored_by_directory = {}

vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("MiniFilesGitIgnore", { clear = true }),
  pattern = { "MiniFilesBufferUpdate", "MiniFilesExplorerClose" },
  callback = function()
    -- BufferUpdate runs after highlighting, so each render gets fresh Git results.
    ignored_by_directory = {}
  end,
})

return function(entry)
  local directory = vim.fs.dirname(entry.path)
  local ignored = ignored_by_directory[directory]
  if ignored == nil then
    ignored = {}
    ignored_by_directory[directory] = ignored
    local paths = {}
    for name in vim.fs.dir(directory) do
      paths[#paths + 1] = directory .. "/" .. name
    end
    if #paths > 0 then
      local ok, result = pcall(function()
        return vim.system({ "git", "-C", directory, "check-ignore", "--stdin", "-z" }, {
          stdin = table.concat(paths, "\0") .. "\0",
        }):wait(1000)
      end)
      if ok and result.code == 0 then
        for path in result.stdout:gmatch("[^%z]+") do
          ignored[path] = true
        end
      end
    end
  end
  if ignored[entry.path] then
    return "Comment"
  end
  return MiniFiles.default_highlight(entry)
end
