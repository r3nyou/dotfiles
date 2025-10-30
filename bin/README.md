# Custom Shell Scripts

## 存放位置

```

/usr/local/bin

````


## 如何新增一個新指令

以下步驟將示範如何建立一個名為 `<command-name>` 的新指令。

**請將 `<command-name>` 替換為您想要的實際指令名稱**（例如：`git-auto-commit`、`clean-downloads` 或 `backup-dotfiles`）。

### 步驟 1. 檢查（或建立）目標目錄

首先，在終端機檢查 `/usr/local/bin` 是否存在。

```bash
ls /usr/local/bin
````

  * 如果顯示檔案列表（或一片空白），表示目錄已存在，請跳至步驟 2。
  * 如果顯示 `No such file or directory`，請用以下指令建立它（需要管理者密碼）：

<!-- end list -->

```bash
sudo mkdir -p /usr/local/bin
```

### 步驟 2. 建立新的腳本檔案

使用 `sudo` 搭配 `nano` (或您偏好的文字編輯器) 來在目標位置建立新檔案。

```bash
sudo nano /usr/local/bin/<command-name>
```

*範例：若要建立 `git-auto-commit`，指令就是 `sudo nano /usr/local/bin/git-auto-commit`*

### 步驟 3. 貼上您的腳本內容

在 `nano` 編輯器中，貼上您準備好的腳本。

**重要：** 腳本的第一行（Shebang）必須指定要使用的 shell，例如：

```bash
#!/bin/bash
# ... 您的腳本內容 ...
```

或者，如果您的 Mac 使用 Zsh (較新版 Mac 的預設值)：

```bash
#!/bin/zsh
# ... 您的腳本內容 ...
```

### 步驟 4. 儲存並離開編輯器

(以 `nano` 為例)

1.  按下 `Control + O`
2.  按下 `Enter` 確認檔名
3.  按下 `Control + X` 離開

### 步驟 5. 賦予執行權限

剛建立的檔案只是一個文字檔，您需要讓它變成「可執行」狀態：

```bash
sudo chmod +x /usr/local/bin/<command-name>
```

範例：`sudo chmod +x /usr/local/bin/git-auto-commit`

## 如何使用

恭喜！您已成功新增指令。

1.  開啟一個新的終端機視窗
2.  現在，您可以在**任何目錄**下直接輸入您剛剛建立的指令名稱來執行它：

```bash
<command-name>
```
