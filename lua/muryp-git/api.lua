local listBranch = require 'muryp-git.telescope.branch'
local listRemote = require 'muryp-git.telescope.remote'
local M = {}

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
  end)
end

---TODO: rebase,squash,merge
M.pull = function(Args)
  local isUseSsh = Args.isUseSsh
  -- local isRebase = Args.isRebase
  -- local isSquash = Args.isSquash
  -- local isMerge = Args.isMerge

  listBranch(function(BRANCH)
    listRemote(function(REMOTE_NAME)
      local CMD = 'term '
      if isUseSsh then
        CMD = CMD .. 'eval "$(ssh-agent -s)" && ssh-add ' .. _G.SSH_DIR .. ' && '
      end
      CMD = CMD .. 'git pull ' .. REMOTE_NAME .. ' ' .. BRANCH
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
    vim.cmd 'git reset --hard HEAD^'
  else
    vim.cmd 'git reset --soft HEAD^'
  end
end
M.revert2 = function(isHard)
  if isHard then
    vim.cmd 'git reset --hard HEAD^^'
  else
    vim.cmd 'git reset --soft HEAD^^'
  end
end
M.open = function()
  listRemote(function(REMOTE_NAME)
    local VAL_REMOTE = vim.fn.system('git config --get remote.' .. REMOTE_NAME .. '.url')
    local sshToHttps = string.gsub(VAL_REMOTE, 'git@', 'https://'):gsub(':', '')
    vim.fn.system('xdg-open ' .. sshToHttps)
  end)
end

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

return M
