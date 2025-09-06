# vimlink.nvim

A Neovim plugin that captures tmux window output, detects file paths and pipes them into a Telescope file dialog.

## Installation

Install using `lazy.nvim` or your preferred plugin manager.

```lua
-- In your plugins list
{
  "jmadotgg/vimlink.nvim",
  lazy = false, -- Needs to be false 
}

-- in after
require('vimlink').setup({})
