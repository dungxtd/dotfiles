# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="alanpeabody"
plugins=(git)
source $ZSH/oh-my-zsh.sh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# bun
[ -s "/Users/dell/.bun/_bun" ] && source "/Users/dell/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

alias cl='claude --dangerously-skip-permissions'
alias cx='codex --dangerously-bypass-approvals-and-sandbox'

export PATH="/Users/dell/.antigravity/antigravity/bin:$PATH"

eval "$(/Users/dell/.local/bin/mise activate zsh)"

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"
