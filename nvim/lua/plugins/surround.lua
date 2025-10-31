-- lua/plugins/surround.lua

return {
  "kylechui/nvim-surround",
  version = "*", -- Pin a version by tag
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      -- 您可以在這裡加入自定義設定，如果需要的話
    })
  end
}
