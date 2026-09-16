# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ls='eza'
alias cat='bat'
alias vi='nvim'
alias vim='nvim'
alias ccc='claude'
alias gs='git status'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# Homebrew / PHP / Java / Composer 的 PATH 已移到 ~/.zprofile，讓非互動的
# login shell（腳本、遠端執行）也吃得到。非 login 的互動 shell（編輯器內建
# 終端等）不讀 .zprofile，所以這裡補一次；已經有就整段跳過。
if [[ ":$PATH:" != *":/opt/homebrew/opt/php@8.3/bin:"* ]]; then
  [[ ":$PATH:" == *":/opt/homebrew/bin:"* ]] || eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH="$HOME/.composer/vendor/bin:$PATH"
  export PATH="/opt/homebrew/opt/php@8.3/bin:$PATH"
  export PATH="/opt/homebrew/opt/php@8.3/sbin:$PATH"
  export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
fi
export JAVA_HOME="/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"

export NVM_DIR="$HOME/.nvm"
# 不在啟動時載入 nvm.sh（那是幾千行 shell script，每開一個終端就要跑一遍）。
# 改成直接把預設版本放進 PATH —— gemini / codex 的 #!/usr/bin/env node 需要真的找得到 node。
# 換預設 node 版本時改這一行。
export PATH="$NVM_DIR/versions/node/v22.22.0/bin:$PATH"
# 真的呼叫 nvm 時才載入完整功能（nvm use / install / ls 都正常）
nvm() { unset -f nvm; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; nvm "$@"; }


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# 註：brew shellenv 已在 ~/.zprofile 執行，這裡不可重複呼叫
#     否則會把 /opt/homebrew/bin 重新插到 php@8.3 前面，讓上面的 php@8.3 設定失效
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Added by Antigravity
export PATH="/Users/marcus.chen/.antigravity/antigravity/bin:$PATH"

# cp-web-next 本機 dev server（需 sudo 綁 port 80，固定用 node 22.22.0）
cpwebnext() {
  cd /Users/marcus.chen/Documents/code/asiayo/cp-web-next || return
  sudo env "PATH=$HOME/.nvm/versions/node/v22.22.0/bin:/opt/homebrew/bin:/usr/bin:/bin" /opt/homebrew/bin/yarn dev
}

# --- Android SDK (added for app-expo dev) ---
export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$ANDROID_HOME/cmdline-tools/latest/bin"
# --- end Android SDK ---

# ~/.local/bin 放最後才 prepend，確保它排在 pyenv shims / brew 之前
# （claude、codex、gemini、uv 都在這裡）
export PATH="$HOME/.local/bin:$PATH"

# PATH 去重（保留最前面那筆），避免各家安裝程式重複附加
typeset -U path PATH

