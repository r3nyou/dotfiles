# cursor+neovim setting

## 前置設定

1. nvim 資料夾放到 `~/.config` 底下
2. cursor 安裝套件 neovim, project manager, copy with context


## 常用功能

* `gd`：(Go to Definition)
* `<leader>qr`：(Find all reference)
* `CMD + 1`：打開/切換到 Terminal
* `CMD + 2`：打開/切換到 AI Chat
* `CMD + 3`：打開/切換到 Git Changes
* `CMD + Shift + P`：切換不同資料夾的專案

## 視窗與面板操作

* `CMD + CTRL + H`：專注於左側面板 (Focus Left Panel)
* `CMD + CTRL + J`：在分割視窗狀態下，於不同編輯視窗間跳轉

## 複製與貼上

* `:Fr`：複製檔案相對路徑
* `:Fc`：複製 (帶有上下文)
* `<leader> y`：複製到系統剪貼簿
* `<leader> p`：從系統剪貼簿貼上

## 檔案總管操作 (`<leader>tt`)

進入 File Explorer (檔案總管) 模式後，支援以下操作：

### 導航

* `j`：向下移動
* `k`：向上移動
* `h`：收合資料夾 / 向左
* `l`：展開資料夾 / 選擇檔案 / 向右
* `Enter`：選取檔案或資料夾
* `gg`：跳轉到列表頂部
* `G`：跳轉到列表底部

### 檔案/資料夾操作

* `a`：建立新檔案 (Create New File)
* `A`：建立新資料夾 (Create New Folder)
* `r`：重新命名 (Rename)
* `d`：刪除 (Delete)
* `y`：複製 (Copy)
* `x`：剪下 (Cut)
* `p`：貼上 (Paste)
