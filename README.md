[![License: Apache](https://img.shields.io/badge/License-Apache-blue.svg)](https://opensource.org/licenses/Apache-2.0)
![Neovim version](https://img.shields.io/badge/Neovim-0.8.x-green.svg)
![Lua version](https://img.shields.io/badge/Lua-5.4-yellow.svg)
[![Repo Size](https://img.shields.io/github/repo-size/muryp/muryp-git-setup.nvim)](https://github.com/muryp/muryp-git-setup.nvim)
[![Latest Release](https://img.shields.io/github/release/muryp/muryp-git-setup.nvim)](https://github.com/muryp/muryp-git-setup.nvim/releases/latest)
[![Last Commit](https://img.shields.io/github/last-commit/muryp/muryp-git-setup.nvim)](https://github.com/muryp/muryp-git-setup.nvim/commits/master)
[![Open Issues](https://img.shields.io/github/issues/muryp/muryp-git-setup.nvim)](https://github.com/muryp/muryp-git-setup.nvim/issues)

# Plugin Nvim MuryP Git
easy use git, with telescope and wichkey.
## requirement
- nvim 0.8+ (recommendation)
- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [sindrets/diffview.nvim](https://github.com/sindrets/diffview.nvim)
- [akinsho/git-conflict.nvim](https://github.com/akinsho/git-conflict.nvim)
- [folke/which-key.nvim](https://github.com/folke/which-key.nvim)
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

> if some plugins not found you can still used it, but you can use it

## install
- lazy.nvim
```lua
{
  'muryp/muryp-git-setup.nvim',
}
```

## configs
```lua
-- disable maps
require('muryp-git-setup').useMaps = false
-- rewrite maps
require('muryp-git-setup').MAPS[1].t = {':cmdt<CR>','DESCRIPTIONt'}
require('muryp-git-setup').MAPS[1].g = { name = 'some description', h = { ':cmdg<CR>','DESCRIPTIONg'},}
require('muryp-git-setup').MAPS[2] = { prefix = "<leader>", noremap = true, mode = 'n', silent = true }
```

## Api
- git cmd main
```lua
M.gitMainCmd({
  add = true,          -- use git add . ? => boolean|nil
  commit = true,       -- use commit? => boolean|nil
  ssh = true,          -- use ssh? => boolean|nil
  pull = true,         -- use pull? => boolean|nil
  pull_quest = true,   -- ask use pull => boolean|nil
  push = true,         -- push => boolean|nil
  remote_quest = true, -- custom remote => boolean|nil
  remote = true,       -- default remote => string
})
```

## Telescope Register
- `Telescope git_flow` : checkout and merge
- `Telescope git_pull` : pull request from remote
- `Telescope git_commit_ssh_push` : commit ssh push with option remote

## Lisensi
The `muryp-git-setup` plugin is distributed under the **Apache License 2.0**. Please refer to the `LICENSE` file for more information about this license.

## Contributing
We greatly appreciate contributions from anyone can produce **issue** or **maintaine code** to help this repo. Please read `CONTRIBUTE.md` for more info.