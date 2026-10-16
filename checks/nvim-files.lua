local tmp = vim.fn.tempname()
local files = require("mini.files")
local function write(path, lines)
  vim.fn.mkdir(vim.fs.dirname(path), "p")
  vim.fn.writefile(lines or {}, path)
end
local function git(directory, ...)
  local command = { "git", "-C", directory }
  vim.list_extend(command, { ... })
  local result = vim.system(command):wait()
  assert(result.code == 0, result.stderr)
end
local function rendered_names()
  local buffer = vim.api.nvim_get_current_buf()
  local highlights = {}
  for _, mark in ipairs(vim.api.nvim_buf_get_extmarks(buffer, -1, 0, -1, { details = true })) do
    local entry = files.get_fs_entry(buffer, mark[2] + 1)
    if entry and mark[4].end_row == mark[2] + 1 then
      highlights[entry.name] = mark[4].hl_group
    end
  end
  return highlights
end
local function assert_names(directory, expected)
  assert(files.open(directory, false) ~= false)
  files.synchronize()
  local highlights = rendered_names()
  for name, highlight in pairs(expected) do
    assert(highlights[name] == highlight, name .. ": " .. vim.inspect(highlights[name]) .. " ~= " .. highlight)
  end
  files.close()
end
local ok, err = xpcall(function()
  vim.o.lines = 50
  vim.o.columns = 160
  local repo = tmp .. "/repo"
  vim.fn.mkdir(repo, "p")
  git(repo, "init", "--quiet")
  write(tmp .. "/global-ignore", { "*.global" })
  git(repo, "config", "core.excludesFile", tmp .. "/global-ignore")
  write(repo .. "/.gitignore", { "*.log", "!keep.log", "cache/", "*.tracked" })
  for _, name in ipairs({ "ignored.log", "keep.log", "normal.txt", "file.global", "file.tracked", "line\nbreak.log" }) do
    write(repo .. "/" .. name)
  end
  write(repo .. "/cache/child.txt")
  write(repo .. "/nested/.gitignore", { "local.txt" })
  write(repo .. "/nested/local.txt")
  write(repo .. "/nested/normal.txt")
  git(repo, "add", "--force", "file.tracked")
  assert_names(repo, {
    ["ignored.log"] = "Comment",
    ["line\nbreak.log"] = "Comment",
    ["file.global"] = "Comment",
    ["cache"] = "Comment",
    ["keep.log"] = "MiniFilesFile",
    ["file.tracked"] = "MiniFilesFile",
    ["normal.txt"] = "MiniFilesFile",
    ["nested"] = "MiniFilesDirectory",
  })
  assert_names(repo .. "/cache", { ["child.txt"] = "Comment" })
  assert_names(repo .. "/nested", { ["local.txt"] = "Comment", ["normal.txt"] = "MiniFilesFile" })

  files.open(repo, false)
  write(repo .. "/.gitignore", { "normal.txt" })
  files.synchronize()
  local refreshed = rendered_names()
  assert(refreshed["normal.txt"] == "Comment", "Refresh did not mute the newly ignored file")
  assert(refreshed["ignored.log"] == "MiniFilesFile", "Refresh did not restore the unignored file")
  files.close()

  write(tmp .. "/outside/plain.txt")
  assert_names(tmp .. "/outside", { ["plain.txt"] = "MiniFilesFile" })
  print("mini.files rendered Git-ignore highlight checks passed")
end, debug.traceback)
pcall(files.close)
vim.fn.delete(tmp, "rf")
if not ok then
  vim.api.nvim_err_writeln(err)
  vim.cmd("cquit 1")
end
