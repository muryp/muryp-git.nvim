[![License: Apache](https://img.shields.io/badge/License-Apache-blue.svg)](https://opensource.org/licenses/Apache-2.0)
![Neovim version](https://img.shields.io/badge/Neovim-0.10.x-green.svg)
![Lua version](https://img.shields.io/badge/Lua-5.4-yellow.svg)
[![Repo Size](https://img.shields.io/github/repo-size/muryp/muryp-git-setup.nvim)](https://github.com/muryp/muryp-git-setup.nvim)
[![Latest Release](https://img.shields.io/github/release/muryp/muryp-git-setup.nvim)](https://github.com/muryp/muryp-git-setup.nvim/releases/latest)
[![Last Commit](https://img.shields.io/github/last-commit/muryp/muryp-git-setup.nvim)](https://github.com/muryp/muryp-git-setup.nvim/commits/master)
[![Open Issues](https://img.shields.io/github/issues/muryp/muryp-git-setup.nvim)](https://github.com/muryp/muryp-git-setup.nvim/issues)
[![Linting and style checking](https://github.com/muryp/muryp-git.nvim/actions/workflows/lint.yml/badge.svg)](https://github.com/muryp/muryp-git.nvim/actions/workflows/lint.yml)

# Plugin Nvim MuryP Git
This plugins for manage git in neovim. Like commit, push, PR ,etc.

## requirement
- nvim 0.8+ (recommendation)
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

> if some plugins not found you can still used it, but you can use it

## install
- lazy.nvim
```lua
  {
    'muryp/muryp-git.nvim',
    config = function()
      --PATH SSH DIR
      _G.SSH_DIR = vim.fn.getenv 'HOME' .. '/.ssh/github'
      --PATH GIT DIR for cache
      _G.MURYP_GIT_DIR = vim.fn.getenv 'HOME' .. '/.muryp/nvim/git/'
      require 'muryp-git'
    end,
  }
```

## configs

> see example configs in [here](https://github.com/aliefprihantoro/conf.nvim/blob/main/lua/maps/git.lua)

## Api
> before use api you need to `local git = require('muryp-git.api')`
### BRANCH
- `git.branch.create` => CREATE
- `git.branch.renameCurr` => RENAME_CURR
- `git.branch.renameList` => RENAME_LIST
- `git.branch.rm` => REMOVE
### FLOW
- `git.flow { isRebase = true }` => CHECKOUT AND REBASE
- `git.flow { isMerge = true }` => CHECKOUT AND MERGE
- `git.flow { isSquash = true }` => CHECKOUT AND SQUASH
### COMMIT AND PUSH
- `git.commit { isAmend = true }` => COMMIT
- `git.push { isUseSsh = true, isPull = true, isCommit = true, isAddAll = true, }` => ADD,COMMIT,PUSH,PULL
### PULL
> isUseSsh => use ssh to pull, change to false if you not use it.
- `git.pull { isUseSsh = true, isSquash = true, }` => PULL AND SQUASH
- `git.pull { isUseSsh = true, isRebase = true, }` => PULL AND REBASE
- `git.pull { isUseSsh = true, isMerge = true, }` => PULL AND MERGE
### MERGE
- `git.merge` => MERGE
- `git.squash` => SQUASH
- `git.rebase` => REBASE
### REMOTE
- `git.remote.add` => CREATE
- `git.remote.rename` => RENAME
- `git.remote.rm` => REMOVE
- `git.remote.sshToHttp` => SSH_TO_HTTP
- `git.remote.httpToSsh` => HTTP_TO_SSH
- `git.remote.open` => OPEN IN BROWSER

## Lisensi
The `muryp-git-setup` plugin is distributed under the **Apache License 2.0**. Please refer to the `LICENSE` file for more information about this license.

## Contributing
We greatly appreciate contributions from anyone can produce **issue** or **maintaine code** to help this repo. Please read `CONTRIBUTE.md` for more info.