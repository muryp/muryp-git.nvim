local picker = require 'muryp-git.utils.picker'

---@param callback function -- function for get remote
return function(callback)
  local getLogHash = vim.fn.system 'git log --pretty=format:"%h"'
  local ListLogHash = vim.split(getLogHash, '\n')

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
    ListOption = ListLogHash,
    callBack = callBack,
    title = 'choose your hash',
  }
end
