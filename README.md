# dotfiles

Personal shell config for macOS and Ubuntu, managed with [chezmoi](https://www.chezmoi.io).

## Setup new machine

```bash
# install chezmoi (macOS: brew install chezmoi; Linux: sh -c "$(curl -fsLS get.chezmoi.io)")
chezmoi init --apply dungxtd/dotfiles
```

This clones the source to `~/.local/share/chezmoi` and renders `~/.bashrc` and
`~/.zshrc` for the current OS. Bash is the default shell on Linux (`chsh -s
/usr/bin/bash`); `~/.profile` sources `~/.bashrc` for login shells. On first zsh
launch, `~/.zshrc` automatically:
- installs [zinit](https://github.com/zdharma-continuum/zinit) plugin manager
- downloads and caches all plugins

Subsequent terminal opens are fast (~110ms) — plugins load lazily after the first
prompt via zinit turbo mode (`wait lucid`).

## Everyday use

```bash
chezmoi edit ~/.bashrc    # edit the source template (or ~/.zshrc)
chezmoi apply             # render + write ~/.bashrc, ~/.zshrc
chezmoi diff              # preview pending changes
chezmoi update            # git pull + apply (sync a machine)
chezmoi cd                # open the source repo for git operations
```

## Files

- `dot_bashrc.tmpl` → `~/.bashrc`
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

Bash (`~/.bashrc`):
- [flyline](https://github.com/HalFrgrd/flyline) line editor (bash loadable
  builtin), loaded from the first build found: `$BREW_PREFIX/lib/bash/flyline`
  (host, `brew install flyline`) or `/usr/local/lib/bash/libflyline.so` (containers)
- same aliases, PATH extras, mise, rdp and work-machine bits as `~/.zshrc`
- prompt `user cwd$` matching the zsh prompt
