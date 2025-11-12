local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- remap leader key
keymap("n", ",", "", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- yank to system clipboard
keymap({"n", "v"}, "<leader>y", '"+y', opts)

-- paste from system clipboard
keymap({"n", "v"}, "<leader>p", '"+p', opts)

-- better indent handling
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- paste preserves primal yanked piece
keymap("v", "p", '"_dP', opts)

-- removes highlighting after escaping vim search
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)

-- 自動輸入法切換 --
-- 此功能依賴 'im-select' 工具: $ brew install im-select
-- 檢查並修改 'writing_im' 為你自己的中文輸入法 ID
local english_im = "com.apple.keylayout.ABC"
local writing_im = "com.apple.inputmethod.TCIM.Zhuyin" -- <== 檢查這裡！
local last_im = english_im
local im_switch_group = vim.api.nvim_create_augroup("IM_SWITCH", { clear = true })

vim.api.nvim_create_autocmd("InsertLeave", {
  group = im_switch_group,
  pattern = "*",
  callback = function()
    if vim.fn.executable("im-select") == 1 then
      last_im = vim.fn.trim(vim.fn.system("im-select"))
      vim.fn.system("im-select " .. english_im)
    else
      print("Error: 'im-select' not found. macOS IM switching is disabled.")
    end
  end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
  group = im_switch_group,
  pattern = "*",
  callback = function()
    if vim.fn.executable("im-select") == 1 then
      local target_im = (last_im and last_im ~= english_im) and last_im or writing_im
      vim.fn.system("im-select " .. target_im)
    end
  end,
})

-- [[ 從 keybindings.json 移轉的功能 ]]

-- , r r -> 快速開啟檔案 (Quick Open)
keymap({"n", "v"}, "<leader>rr", "<cmd>lua require('vscode').action('workbench.action.quickOpen')<CR>")

-- , s s -> 編輯器內尋找 (Editor Find)
keymap({"n", "v"}, "<leader>ss", "<cmd>lua require('vscode').action('actions.find')<CR>")

-- , q q -> 在所有檔案中尋找 (Find in Files)
keymap({"n", "v"}, "<leader>qq", "<cmd>lua require('vscode').action('workbench.action.findInFiles')<CR>")

-- , x 1 -> 單一編輯器佈局 (Single Editor Layout)
keymap({"n", "v"}, "<leader>x1", "<cmd>lua require('vscode').action('workbench.action.editorLayoutSingle')<CR>")
--
-- , x 3 -> Split Editor Layout
keymap({"n", "v"}, "<leader>x3", "<cmd>lua require('vscode').action('workbench.action.splitEditor')<CR>")

-- , q t -> 切換側邊欄 (Toggle Sidebar)
keymap({"n", "v"}, "<leader>qt", "<cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility')<CR>")

-- , t t -> 開啟檔案總管 (Open Explorer)
keymap({"n", "v"}, "<leader>tt", "<cmd>lua require('vscode').action('workbench.view.explorer')<CR>")

-- , f s -> 尋找符號 (Find Symbol in Editor)
keymap({"n", "v"}, "<leader>fs", "<cmd>lua require('vscode').action('workbench.action.gotoSymbol')<CR>")

-- , i i -> 顯示所有符號 (Show All Symbols)
keymap({"n", "v"}, "<leader>ii", "<cmd>lua require('vscode').action('workbench.action.showAllSymbols')<CR>")

-- , q r -> find all reference
keymap({"n", "v"}, "<leader>qr", "<cmd>lua require('vscode').action('references-view.findReferences')<CR>")

-- project manager keymaps(需要 project manager extension)
keymap({"n", "v"}, "<leader>pa", "<cmd>lua require('vscode').action('projectManager.saveProject')<CR>")
keymap({"n", "v"}, "<leader>po", "<cmd>lua require('vscode').action('projectManager.listProjectsNewWindow')<CR>")
keymap({"n", "v"}, "<leader>pe", "<cmd>lua require('vscode').action('projectManager.editProjects')<CR>")

-- [[ neovim user command ]]

-- 複製檔案路徑
vim.api.nvim_create_user_command(
    'Fr',
    function()
        require('vscode').action('copyRelativeFilePath')
    end,
    {
        desc = 'Copy relative file path (vscode action)'
    }
)

-- 需安裝 copy with context extension
vim.api.nvim_create_user_command(
    'Fc',
    function(opts)
        -- 1. 執行 normal 模式指令 'gv'
        -- 'gv' 會重新選取由 '< 和 '> 標記定義的最後一個視覺選區
        -- 這會讓 Neovim 重新進入 Visual 模式並反白該區域
        vim.cmd("normal! gv")
        
        -- 2. 在程式碼已被重新選取的狀態下，立刻呼叫 action
        require('vscode').action('copy-with-context.copyWithContext')
    end,
    {
        desc = 'Calls vscode copy-with-context action',
        range = true -- 這一行仍然是必要的，它確保 '< 和 '> 標記被正確設置
    }
)
