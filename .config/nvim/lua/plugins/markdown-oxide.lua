local vault_path = vim.fn.expand("~/Documents/forge")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        markdown_oxide = {},
      },
      setup = {
        markdown_oxide = function(_, opts)
          require("lspconfig").markdown_oxide.setup(opts)
          return true
        end,
      },
    },
    keys = {
      {
        "<leader>nd",
        function()
          local date = os.date("%Y-%m-%d")
          local path = vault_path .. "/daily/" .. date .. ".md"
          vim.cmd("edit " .. path)
        end,
        desc = "Open daily note",
      },
      {
        "<leader>nn",
        function()
          vim.ui.input({ prompt = "Note name: " }, function(name)
            if name and name ~= "" then
              local path = vault_path .. "/docs/" .. name .. ".md"
              vim.cmd("edit " .. path)
            end
          end)
        end,
        desc = "New note",
      },
    },
  },
}
