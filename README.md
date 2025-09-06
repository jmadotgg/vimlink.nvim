# vimlink.nvim

A Neovim plugin that captures tmux window output, detects file pahts and pipes them into a Telescope file dialog.

## Installation

Install using `lazy.nvim` or your preferred plugin manager.

```lua
-- In your plugins list
{
  "jmadotgg/vimlink.nvim",
  lazy = false, -- Needs to be false 
  config = function()
    -- Your commands and keymaps will be defined automatically
  end
}
