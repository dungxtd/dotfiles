# dotfiles

Personal shell config for macOS and Ubuntu. Symlinked into `$HOME`.

## Setup new machine

```bash
git clone https://github.com/dungxtd/dotfiles.git ~/dotfiles
ln -sf ~/dotfiles/zshrc ~/.zshrc
source ~/.zshrc
```

zinit and all plugins are auto-installed on first terminal open.

## Files

- `zshrc` → `~/.zshrc`

## What's included

- [zinit](https://github.com/zdharma-continuum/zinit) plugin manager
- [alanpeabody](https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/alanpeabody.zsh-theme) theme (no hostname)
- oh-my-zsh git plugin (aliases + prompt info)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [mise](https://mise.jdx.dev) runtime version manager
- [bun](https://bun.sh) JS runtime
