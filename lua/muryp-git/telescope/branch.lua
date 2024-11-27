local picker = require 'muryp-git.utils.picker'

---@param callback function -- function for get remote
---@param isUseCurrBranch true|nil
return function(callback, isUseCurrBranch)
  local getBranchName = vim.fn.system('git branch --list -a'):gsub(' ', ''):gsub('*', '') ---@type string
  -- end
  _G.REMOTE_BRANCH = getBranchName
  local ListBranchName = vim.split(getBranchName, '\n')

  local NAME_CURRENT_BRANCH = vim.fn.system('echo $(git symbolic-ref --short HEAD)'):gsub('[\n\r]', '') ---@type string
  if #ListBranchName == 1 then
    return callback(NAME_CURRENT_BRANCH)
  end
  local NewListBranchName = {}
  if isUseCurrBranch then
    table.insert(NewListBranchName, NAME_CURRENT_BRANCH)
  end

  for _, value in pairs(ListBranchName) do
    local isExclude = (value ~= NAME_CURRENT_BRANCH and value ~= '' and value ~= 'head')
    if isExclude then
      table.insert(NewListBranchName, value)
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
