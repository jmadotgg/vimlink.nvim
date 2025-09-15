local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

local function show_files(vimlink_path)
  local buffer_list = vim.fn.system(vimlink_path)
  local t = {}
  for line in buffer_list:gmatch("[^\r\n]+") do
    table.insert(t, line)
  end
  pickers
    .new({}, {
      finder = finders.new_table({
        results = t,
      }),
      sorter = conf.values.generic_sorter(),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          vim.cmd("e " .. selection.value)
        end)
        return true
      end,
    })
    :find()
end

function M.setup(options)
  vim.api.nvim_create_user_command("Vimlink", function()
    local paths = vim.api.nvim_list_runtime_paths()
    for _, str in ipairs(paths) do
      print(str)
      --if str:match(".*vimlink$") then
      --  return str
      --end
    end
    show_files("./bin/linux/vimlink")
  end, {})

  vim.keymap.set("n", "<leader>vl", ":Vimlink<CR>", {
    desc = "Say hello with first plugin Neovim plugin that captures tmux window output, detects file pahts and pipes them into a Telescope file dialog.",
  })
end

return M
