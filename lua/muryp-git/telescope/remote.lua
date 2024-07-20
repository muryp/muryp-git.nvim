local picker = require 'muryp-git.utils.picker'

---@param callback function -- function for get remote
return function(callback)
  local getRemoteName = vim.fn.system 'git remote'
  local ListRemoteName = vim.split(getRemoteName, '\n')

  if #ListRemoteName == 1 then
    return callback(ListRemoteName[1])
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
    ListOption = ListRemoteName,
    callBack = callBack,
    PREVIEW_OPTS = 'GH_ISSUE',
    title = 'choose your remote',
  }
end
