# 工具盤點

換機器時的重建清單。Brewfile 管不到的記在這裡。

## 重建

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle install --file=Brewfile
cp .zshenv .zprofile .zshrc ~/
```

## Shell

- oh-my-zsh：`sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
- powerlevel10k：`git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k`

`.zshrc` 有三個踩過坑的地方，改動前先讀註解：`brew shellenv` 不可重複呼叫、PHP PATH 要放 `.zprofile`、`~/.local/bin` 的 prepend 必須放最後。

## AI CLI

npm 全域，prefix 設為 `~/.local`。**不要用 brew 裝**，會被 `~/.local/bin` 遮蔽。

```bash
npm i -g @anthropic-ai/claude-code @openai/codex @google/gemini-cli
```

## Python

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

uv 取代 pip / venv / pipx / poetry / pyenv。同樣不要用 brew 裝。

## Node

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
nvm install 22 && nvm alias default 22
```

`.zshrc` 用延遲載入：啟動時只把預設版本加進 PATH，呼叫 `nvm` 時才 source `nvm.sh`。

## GUI

Raycast、Obsidian、Karabiner-Elements、Ghostty、Cursor、Claude、ChatGPT、cmux、Xnip、Clop、The Unarchiver、Buzz（本機語音轉文字）、Typeless（語音輸入）、Xmind

## 編輯器設定

`nvim/`、`cursor/`、`vscode.settings.json`、`vscode.keybindings.json`、`.ideavimrc`

## 自製

`bin/git-auto-commit`、[copy-with-context](https://github.com/r3nyou/copy-with-context)

## 維護

```bash
comm -23 <(brew leaves --installed-on-request | sort) \
         <(grep -oE '^brew "[^"]+"' Brewfile | sed 's/brew "//;s/"//' | sort)
```

有輸出 = 裝了但沒記錄。

## TODO

- [ ] 編輯器擴充清單納入版控
- [ ] Claude Code user settings / agents（注意機密資料）
- [ ] neovim surround
