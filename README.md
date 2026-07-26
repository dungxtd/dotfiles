# dotfiles

Personal shell config for macOS and Ubuntu, managed with [chezmoi](https://www.chezmoi.io).

## Setup new machine

```bash
# install chezmoi (macOS: brew install chezmoi; Linux: sh -c "$(curl -fsLS get.chezmoi.io)")
chezmoi init --apply dungxtd/dotfiles
```

This clones the source to `~/.local/share/chezmoi` and renders `~/.zshrc` for the
current OS. On first shell launch, `~/.zshrc` automatically:
- installs [zinit](https://github.com/zdharma-continuum/zinit) plugin manager
- downloads and caches all plugins

Subsequent terminal opens are fast (~110ms) — plugins load lazily after the first
prompt via zinit turbo mode (`wait lucid`).

## Everyday use

```bash
chezmoi edit ~/.zshrc     # edit the source template
chezmoi apply             # render + write ~/.zshrc
chezmoi diff              # preview pending changes
chezmoi update            # git pull + apply (sync a machine)
chezmoi cd                # open the source repo for git operations
```

## Files

- `dot_zshrc.tmpl` → `~/.zshrc`
- `.chezmoiignore` — keeps `README.md` / `.gitignore` out of `$HOME`

## Cross-OS handling

- Generic OS differences (rdp, ibus, Ctrl+←/→ keybindings) use runtime
  `[[ "$OSTYPE" == linux* ]]` guards — one file works everywhere.
- Work-machine-only bits (Rancher Desktop, Vingroup CA cert, snx-rs VPN) are
  gated behind `{{ if eq .chezmoi.os "linux" }}`, so macOS renders a clean file
  with none of them.

## What's included

- [zinit](https://github.com/zdharma-continuum/zinit) plugin manager (turbo mode)
- oh-my-zsh git library + git plugin (async git prompt, aliases)
- custom `%F/%f` prompt (no hostname; nesting-safe for kiro-cli OSC wrapping),
  branch + git status symbols + exit code in `RPROMPT`
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- cached `compinit` completion system
- [mise](https://mise.jdx.dev) runtime version manager
- [bun](https://bun.sh) JS runtime
