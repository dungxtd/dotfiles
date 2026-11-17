# dotfiles

Personal bash config for Ubuntu (and macOS), managed with [chezmoi](https://www.chezmoi.io).

## Setup new machine

```bash
# install chezmoi (macOS: brew install chezmoi; Linux: sh -c "$(curl -fsLS get.chezmoi.io)")
chezmoi init --apply dungxtd/dotfiles
chsh -s /usr/bin/bash      # bash as login shell (log out/in or reboot after)
brew install flyline       # optional: line editor + right prompt (see below)
```

This clones the source to `~/.local/share/chezmoi` and renders `~/.bashrc` for the
current OS. `~/.profile` (distro default) sources `~/.bashrc` for login shells.

## Everyday use

```bash
chezmoi edit ~/.bashrc    # edit the source template
chezmoi apply             # render + write
chezmoi diff              # preview pending changes
chezmoi update            # git pull + apply (sync a machine)
chezmoi cd                # open the source repo for git operations
```

## Files

- `dot_bashrc.tmpl` → `~/.bashrc`
- `dot_config/bash/git-aliases.bash` → `~/.config/bash/git-aliases.bash`
- `.chezmoiignore` — keeps `README.md` / `.gitignore` out of `$HOME`
- `~/.bashrc.local` — machine-local additions (work functions, internal hosts);
  sourced if present, never committed

## Cross-OS handling

- Linux-only bits (ibus, `rdpx`, Rancher Desktop, work CA cert, snx-rs VPN) are
  gated behind `{{ if eq .chezmoi.os "linux" }}`, so macOS renders a clean file.

## What's included

- [flyline](https://github.com/HalFrgrd/flyline) line editor (bash loadable
  builtin), loaded from the first build found: `$BREW_PREFIX/lib/bash/flyline`
  (`brew install flyline`) or `/usr/local/lib/bash/libflyline.so` (containers)
- prompt: `user cwd$` on the left; on the right (flyline `RPS1`) the last exit
  code `N ↵`, git status symbols (═ ✖ ➜ ✹ ✚ ✭) and the branch
- git aliases/functions (`gst`, `gco`, `gcmsg`, `ggp`, `gpsup`, ...), adapted from
  the ohmyzsh git plugin (MIT)
- `take` / `mkcd`, `k9s` (all `~/.kube/cluster-*` kubeconfigs), `cl` / `cx`
- [mise](https://mise.jdx.dev), [bun](https://bun.sh), Homebrew, bash-completion
