local picker = require 'muryp-git.utils.picker'

---@param callback function -- function for get remote
return function(callback)
  local getRemoteName = vim.fn.system('git branch --list | grep -v $(git rev-parse --abbrev-ref HEAD)'):gsub(' ', '') ---@type string
  local ListBranchName = vim.split(getRemoteName, '\n')

  local NAME_CURRENT_BRANCH = vim.fn.system('echo $(git symbolic-ref --short HEAD)'):gsub('[\n\r]', '') ---@type string
  if #ListBranchName == 1 then
    return callback(NAME_CURRENT_BRANCH)
  end
  local NewListBranchName = {}

  for _, value in pairs(ListBranchName) do
    if value ~= '' then
      table.insert(NewListBranchName, value)
    else
      table.insert(NewListBranchName, 1, NAME_CURRENT_BRANCH)
    end
  end
  local callBack = function(UserSelect)
    if type(UserSelect) == 'string' then
      callback(UserSelect)
    else
      for _, USER_SELECT in pairs(UserSelect) do
        callback(USER_SELECT)
      end
    end
  end

  picker {
    ListOption = NewListBranchName,
    callBack = callBack,
    title = 'choose your branch',
  }
end
