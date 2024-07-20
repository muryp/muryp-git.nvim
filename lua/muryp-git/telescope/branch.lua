local picker = require 'muryp-git.utils.picker'

---@param callback function -- function for get remote
return function(callback)
  local getRemoteName = vim.fn.system('git branch --list | grep -v $(git rev-parse --abbrev-ref HEAD)'):gsub(' ', '') ---@type string
  local ListBranchName = vim.split(getRemoteName, '\n')

  if #ListBranchName == 1 then
    local NAME_CURRENT_BRANCH = vim.fn.system('echo $(git symbolic-ref --short HEAD)'):gsub('[\n\r]', '') ---@type string
    return callback(NAME_CURRENT_BRANCH)
  end

  for _, value in pairs(ListBranchName) do
    local isNotEmty = value ~= ''
    local clearSpace = string.gsub(value, '%s+', '')
    if isNotEmty then
      table.insert(ListBranchName, clearSpace)
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
    ListOption = ListBranchName,
    callBack = callBack,
    title = 'choose your branch',
  }
end
