local M = {}

local function diff_files(state)
  local nodes = {}
  for k, v in pairs(state.selected) do
    if v then
      nodes[#nodes + 1] = k
    end
  end

  if #nodes < 2 then
    vim.notify(
      "Select two files or directories with <Tab>, then press F",
      vim.log.levels.WARN
    )
    return
  end

  if #nodes > 2 then
    vim.notify(
      "[neo-tree-diff] more than two selected; comparing the first two",
      vim.log.levels.WARN
    )
  end

  local left, right = nodes[1], nodes[2]
  state.selected = {}

  print(left, right)
  vim.cmd("tabnew")
  vim.cmd.packadd("nvim.difftool")
  require("difftool").open(left, right, {
    rename = { detect = true },
  })
end

M.diff = function(state)
  diff_files(state)
end

M.diff_visual= function(state, selected_nodes)
  diff_files(state)
end

return M
