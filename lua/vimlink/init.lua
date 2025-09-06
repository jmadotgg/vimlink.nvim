return {
  -- This is the actual plugin spec table. You must return this.
  {
    "jmadotgg/vimlink",
    lazy = false, -- Set to true so it only loads when you need it
    config = function()
      -- All your setup logic goes in here

      local finders = require("telescope.finders")
      local pickers = require("telescope.pickers")
      local conf = require('telescope.config')
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')

      local file_list = {
        "src/main.rs"
      }

      local function show_files(vimlink_path)
        local buffer_list = vim.fn.system(vimlink_path)
	local t = {}
	for line in buffer_list:gmatch("[^\r\n]+") do
		table.insert(t, line)
	end
        pickers.new({}, {
          finder = finders.new_table({
            results = t
          }),
          sorter = conf.values.generic_sorter(),
          attach_mappings = function (prompt_bufnr, map)
            actions.select_default:replace(function ()
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              vim.cmd("e " .. selection.value)
            end)
            return true
          end
        }):find()
      end

      vim.api.nvim_create_user_command("Vimlink", function()
	show_files("./bin/linux/vimlink")
      end, {})

      vim.keymap.set("n", "<leader>vl", show_files, {
        desc = "Say hello with first plugin Neovim plugin that captures tmux window output, detects file pahts and pipes them into a Telescope file dialog."
      })
    end
  }
}
