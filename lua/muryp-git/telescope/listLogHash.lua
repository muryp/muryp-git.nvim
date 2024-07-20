local picker = require 'muryp-git.utils.picker'

---@param callback function -- function for get remote
return function(callback)
  local getRemoteName = vim.fn.system 'git remote'
  local ListRemoteName = vim.split(getRemoteName, '\n')

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
    opts = ListRemoteName,
    callBack = callBack,
    title = 'choose your hash',
  }
end
