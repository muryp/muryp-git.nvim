local picker = require 'muryp-git.utils.picker'

---@param callback function -- function for get remote
return function(hash, callback)
  local getFile = vim.fn.system('git ls-tree --name-only -r ' .. hash)
  local ListFile = vim.split(getFile, '\n')

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
    ListOption = ListFile,
    callBack = callBack,
    title = 'choose your file',
  }
end
