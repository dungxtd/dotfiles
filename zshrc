
# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/.local/share/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/zshrc.pre.zsh"


# PATH dedup
typeset -U path PATH

# Linux-only: input method
[[ "$OSTYPE" == linux* ]] && export GTK_IM_MODULE=ibus

# Detect brew prefix + load shellenv (PATH, MANPATH, INFOPATH)
if [[ -x /opt/homebrew/bin/brew ]]; then
  BREW_PREFIX=/opt/homebrew
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  BREW_PREFIX=/home/linuxbrew/.linuxbrew
fi
[[ -n "$BREW_PREFIX" ]] && eval "$("$BREW_PREFIX/bin/brew" shellenv)"

# zinit — auto-install if missing
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
[[ ! -d $ZINIT_HOME ]] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
declare -A ZINIT
ZINIT[HOME_DIR]="$HOME/.local/share/zinit"
source "$ZINIT_HOME/zinit.zsh"

# Plugins
setopt PROMPT_SUBST
autoload -Uz add-zsh-hook

# required by OMZ::lib/git.zsh but missing from downloaded functions.zsh
function _omz_register_handler() {
  add-zsh-hook chpwd "$1"
  add-zsh-hook precmd "$1"
}

zinit snippet OMZ::lib/functions.zsh
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit light zsh-users/zsh-syntax-highlighting

# Colors (cross-platform: macOS + Ubuntu)
autoload -U colors && colors

# Git prompt vars (used by git_prompt_info from OMZ git lib)
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})%{$reset_color%}"

# Manual prompt (no theme — themes override via precmd)
PROMPT='%{$fg[magenta]%}%n%{$reset_color%} %{$fg[blue]%}%~%{$reset_color%} $(git_prompt_info)$ '

# bun
export BUN_INSTALL="$HOME/.bun"
[[ -d "$BUN_INSTALL/bin" ]] && path=("$BUN_INSTALL/bin" $path)
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

alias cl='claude --dangerously-skip-permissions'
alias cx='codex --dangerously-bypass-approvals-and-sandbox'

[[ -d "$HOME/.antigravity/antigravity/bin" ]] && path=("$HOME/.antigravity/antigravity/bin" $path)
[[ -d "$HOME/scripts" ]] && path=("$HOME/scripts" $path)

if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
elif [[ -x "$HOME/.local/bin/mise" ]]; then
  eval "$($HOME/.local/bin/mise activate zsh)"
elif [[ -n "$BREW_PREFIX" && -x "$BREW_PREFIX/bin/mise" ]]; then
  eval "$($BREW_PREFIX/bin/mise activate zsh)"
fi


# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/.local/share/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/zshrc.post.zsh"
