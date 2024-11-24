local listBranch = require 'muryp-git.telescope.branch'
local listRemote = require 'muryp-git.telescope.remote'
local M = {}

---@param Args {isUseSsh: boolean, isPull: boolean, isCommit: boolean, isAddAll: boolean}
M.push = function(Args)
  local isUseSsh = Args.isUseSsh
  local isPull = Args.isPull
  local isCommit = Args.isCommit
  local isAddAll = Args.isAddAll

  listBranch(function(BRANCH)
    listRemote(function(REMOTE_NAME)
      local CMD = 'term '
      if isUseSsh then
        CMD = CMD .. 'eval "$(ssh-agent -s)" && ssh-add ' .. _G.SSH_DIR .. ' && '
      end
      if isPull then
        CMD = CMD .. 'git pull ' .. REMOTE_NAME .. ' ' .. BRANCH .. ' && '
      end
      if isAddAll then
        CMD = CMD .. 'git add -A && '
      end
      if isCommit then
        CMD = CMD .. 'git commit && '
      end
      CMD = CMD .. 'git push ' .. REMOTE_NAME .. ' ' .. BRANCH
      vim.cmd(CMD)
    end)
  end, true)
end

---TODO: rebase,squash,merge
---@param Args {isUseSsh: boolean,isSquash:boolean,isMerge:boolean,isRebase:boolean}
M.pull = function(Args)
  local isUseSsh = Args.isUseSsh
  local isRebase = Args.isRebase
  local isSquash = Args.isSquash
  local isMerge = Args.isMerge

  listBranch(function(BRANCH)
    listRemote(function(REMOTE_NAME)
      local CMD = 'term '
      if isUseSsh then
        CMD = CMD .. 'eval "$(ssh-agent -s)" && ssh-add ' .. _G.SSH_DIR .. ' && '
      end
      CMD = CMD .. 'git pull ' .. REMOTE_NAME .. ' ' .. BRANCH .. ' && '
      if isMerge then
        CMD = CMD .. 'git merge ' .. REMOTE_NAME .. '/' .. BRANCH
      end
      if isRebase then
        CMD = CMD .. 'git rebase ' .. REMOTE_NAME .. '/' .. BRANCH
      end
      if isSquash then
        CMD = CMD .. 'git merge --squash ' .. REMOTE_NAME .. '/' .. BRANCH
      end
      -- CMD = CMD .. 'git merge ' .. REMOTE_NAME .. ' ' .. BRANCH
      vim.cmd(CMD)
    end)
  end)
end

M.commit = function(isAddAll)
  local CMD = 'term '
  if isAddAll then
    CMD = CMD .. 'git add -A && '
  end
  CMD = CMD .. 'git commit'
  vim.cmd(CMD)
end

M.revert1 = function(isHard)
  if isHard then
    vim.cmd '!git reset --hard HEAD^'
  else
    vim.cmd '!git reset --soft HEAD^'
  end
end
M.revert2 = function(isHard)
  if isHard then
    vim.cmd '!git reset --hard HEAD^^'
  else
    vim.cmd '!git reset --soft HEAD^^'
  end
end

---@param Args {isMerge: boolean, isRebase: boolean}
M.flow = function(Args)
  local isMerge = Args.isMerge
  local isRebase = Args.isRebase

  local CURR_BRANCH = vim.fn.system('git symbolic-ref --short HEAD'):gsub('[\n\r]', '')
  listBranch(function(TARGET_BRANCH)
    local CMD = 'term git checkout ' .. TARGET_BRANCH .. ' && '
    if isMerge then
      CMD = CMD .. 'git merge ' .. CURR_BRANCH
    end
    if isRebase then
      CMD = CMD .. 'git rebase ' .. CURR_BRANCH
    end
    vim.cmd(CMD)
  end)
end

---TODO: PREVIEW
M.browse = function()
  require 'muryp-git.telescope.listLogHash'(function(hash)
    require 'muryp-git.telescope.listFile'(hash, function(file)
      local FILE = _G.MURYP_GIT_DIR .. file
      local DIR = vim.fn.fnamemodify(FILE, ':h')
      local CONTENT = vim.fn.system('git show ' .. hash .. ':' .. file)

      vim.fn.mkdir(DIR, 'p')
      vim.fn.writefile(CONTENT, FILE)
      vim.cmd('e ' .. FILE)
    end)
  end)
end

M.deleteRemote = function()
  listRemote(function(REMOTE_NAME)
    local CMD = 'term git remote remove ' .. REMOTE_NAME
    vim.cmd(CMD)
  end)
end

M.merge = function()
  listBranch(function(BRANCH)
    vim.cmd('term git merge ' .. BRANCH)
  end)
end
M.rebase = function()
  listBranch(function(BRANCH)
    vim.cmd('term git rebase ' .. BRANCH)
  end)
end
M.squash = function()
  listBranch(function(BRANCH)
    vim.cmd('term git merge --squash ' .. BRANCH)
  end)
end

M.remote = {
  add = function()
    local REMOTE_NAME = vim.fn.input 'Enter remote name: '
    local REMOTE_URL = vim.fn.input 'Enter remote url: '
    vim.cmd('term git remote add ' .. REMOTE_NAME .. ' ' .. REMOTE_URL)
  end,
  rename = function()
    listRemote(function(REMOTE_NAME)
      local NEW_NAME = vim.fn.input 'Enter new name: '
      vim.cmd('term git remote rename ' .. REMOTE_NAME .. ' ' .. NEW_NAME)
    end)
  end,
  rm = function()
    listRemote(function(REMOTE_NAME)
      vim.cmd('term git remote remove ' .. REMOTE_NAME)
    end)
  end,
  show = function()
    listRemote(function(REMOTE_NAME)
      local URL = vim.fn.system('git config --get remote.' .. REMOTE_NAME .. '.url')
      print(REMOTE_NAME .. ': ' .. URL)
    end)
  end,
  urlToSsh = function()
    listRemote(function(REMOTE_NAME)
      local OLD_URL = vim.fn.system('git config --get remote.' .. REMOTE_NAME .. '.url')
      local NEW_URL = string.gsub(OLD_URL, 'https://', 'git@'):gsub('github.com/', 'github.com:')
      vim.cmd('term git remote set-url ' .. REMOTE_NAME .. ' ' .. NEW_URL)
    end)
  end,
  sshToUrl = function()
    listRemote(function(REMOTE_NAME)
      local OLD_URL = vim.fn.system('git config --get remote.' .. REMOTE_NAME .. '.url')
      local NEW_URL = string.gsub(OLD_URL, 'git@', 'https://'):gsub('github.com:', 'github.com/')
      vim.cmd('term git remote set-url ' .. REMOTE_NAME .. ' ' .. NEW_URL)
    end)
  end,
  open = function()
    listRemote(function(REMOTE_NAME)
      local VAL_REMOTE = vim.fn.system('git config --get remote.' .. REMOTE_NAME .. '.url')
      local sshToHttps = string.gsub(VAL_REMOTE, 'git@', 'https://'):gsub('github.com:', 'github.com/')
      vim.fn.system('xdg-open ' .. sshToHttps)
    end)
  end,
}

return M
