
# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/.local/share/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/zshrc.pre.zsh"


export GTK_IM_MODULE=ibus

# Detect brew prefix (macOS: /opt/homebrew, Linux: /home/linuxbrew/.linuxbrew)
if [[ -x /opt/homebrew/bin/brew ]]; then
  BREW_PREFIX=/opt/homebrew
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  BREW_PREFIX=/home/linuxbrew/.linuxbrew
fi

# zinit — auto-install if missing
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
[[ ! -d $ZINIT_HOME ]] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
declare -A ZINIT
ZINIT[HOME_DIR]="$HOME/.local/share/zinit"
source "$ZINIT_HOME/zinit.zsh"

# Plugins
setopt PROMPT_SUBST
autoload -U colors && colors
autoload -Uz add-zsh-hook

# required by OMZ::lib/git.zsh but missing from downloaded functions.zsh
function _omz_register_handler() {
  add-zsh-hook chpwd "$1"
  add-zsh-hook precmd "$1"
}

zinit snippet OMZ::lib/functions.zsh
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::themes/alanpeabody.zsh-theme
zinit light zsh-users/zsh-syntax-highlighting

function ruby_prompt_info() { }

# Override prompt (remove hostname)
PROMPT='%{$fg[magenta]%}%n%{$reset_color%} %{$fg[blue]%}%~%{$reset_color%}$ '

# bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

alias cl='claude --dangerously-skip-permissions'
alias cx='codex --dangerously-bypass-approvals-and-sandbox'

export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
export PATH="$HOME/scripts:$PATH"

eval "$($BREW_PREFIX/bin/mise activate zsh)"


# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/.local/share/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/zshrc.post.zsh"
