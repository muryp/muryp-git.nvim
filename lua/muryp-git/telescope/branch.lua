local picker = require 'muryp-git.utils.picker'

---@param callback function -- function for get remote
return function(callback)
  local getLogHash = vim.fn.system 'git log --pretty=format:"%h"'
  local ListLogHash = vim.split(getLogHash, '\n')

  for _, value in pairs(ListLogHash) do
    local isNotEmty = value ~= ''
    local clearSpace = string.gsub(value, '%s+', '')
    if isNotEmty then
      table.insert(ListLogHash, clearSpace)
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
    opts = ListLogHash,
    callBack = callBack,
    title = 'choose your branch',
  }
end
