
# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/.local/share/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/zshrc.pre.zsh"


export GTK_IM_MODULE=ibus

# Open PAM RDP file with drive transfer support
rdp() {
  echo "redirectdrives:i:1" >> "$1"
  echo "screen mode id:i:1" >> "$1"
  xfreerdp "$1" /drive:transfer,"$HOME/Downloads" /cert:ignore
}

# Detect brew prefix (macOS: /opt/homebrew, Linux: /home/linuxbrew/.linuxbrew)
if [[ -x /opt/homebrew/bin/brew ]]; then
  BREW_PREFIX=/opt/homebrew
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  BREW_PREFIX=/home/linuxbrew/.linuxbrew
fi

[[ -n $BREW_PREFIX ]] && eval "$($BREW_PREFIX/bin/brew shellenv)"

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

# Required by OMZ::lib/git.zsh's async git prompt machinery.
# Creates a capture wrapper per worker that stores output into the cache
# array that git_prompt_info/git_prompt_status read from, instead of
# echoing to terminal directly.
typeset -gA _OMZ_ASYNC_OUTPUT
function _omz_register_handler() {
  local fn="$1"
  eval "function _omz_capture_${fn}() { _OMZ_ASYNC_OUTPUT[${fn}]=\"\$(${fn})\" }"
  add-zsh-hook chpwd "_omz_capture_${fn}"
  add-zsh-hook precmd "_omz_capture_${fn}"
}

zinit snippet OMZ::lib/functions.zsh
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZ::themes/alanpeabody.zsh-theme
zinit light zsh-users/zsh-syntax-highlighting

function ruby_prompt_info() { }

# Override prompt (remove hostname) — uses %F/%f (nesting-safe) instead of
# %{...%}, since kiro-cli's OSC prompt-wrapping also uses %{...%} and zsh
# does not support nesting those markers.
PROMPT='%F{magenta}%n%f %F{blue}%~%f$ '

ZSH_THEME_GIT_PROMPT_PREFIX="%F{green}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_ADDED="%F{green} ✚%f"
ZSH_THEME_GIT_PROMPT_MODIFIED="%F{blue} ✹%f"
ZSH_THEME_GIT_PROMPT_DELETED="%F{red} ✖%f"
ZSH_THEME_GIT_PROMPT_RENAMED="%F{magenta} ➜%f"
ZSH_THEME_GIT_PROMPT_UNMERGED="%F{yellow} ═%f"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{cyan} ✭%f"

RPROMPT='%(?..%F{red}%? ↵%f) $(git_prompt_status)$(git_prompt_info)'

# bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

alias cl='claude --dangerously-skip-permissions'
alias cx='codex --dangerously-bypass-approvals-and-sandbox'

export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
export PATH="$HOME/scripts:$PATH"

_mise=$(
  command -v "$HOME/.local/bin/mise" 2>/dev/null ||
  { [ -n "$BREW_PREFIX" ] && command -v "$BREW_PREFIX/bin/mise" 2>/dev/null; } ||
  command -v mise 2>/dev/null
)
[ -n "$_mise" ] && eval "$($_mise activate zsh)"
unset _mise


# Word navigation with Ctrl+Left/Right
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[Oc" forward-word
bindkey "^[Od" backward-word


### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/home/dungtd19/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

export NODE_EXTRA_CA_CERTS="/home/dungtd19/Documents/vingroup-enterprise-ca/vingroup-enterprise-ca.pem"

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/.local/share/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/zshrc.post.zsh"
[[ -f "$HOME/.config/snx-rs/vs-shell.sh" ]] && source "$HOME/.config/snx-rs/vs-shell.sh"
