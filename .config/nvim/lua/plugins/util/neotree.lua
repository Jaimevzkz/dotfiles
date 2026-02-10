return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = false,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        follow_current_file = {
          true,
        },
        hijack_netrw_behavior = "open_current",
        filtered_items = {
          visible = true,         
          hide_dotfiles = false,  
          hide_gitignored = false, 
        },
      },
      window = {
        width = 30,
      }
    })
    vim.keymap.set('n', '<C-n>', ':Neotree reveal<CR>', {})
  end
}
