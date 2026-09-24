# dotfiles

Personal dotfiles managed with [yadm](https://yadm.io/).

## Features

This configuration is built around [zsh](https://www.zsh.org/) and uses [zinit](https://github.com/zdharma-continuum/zinit) as its plugin manager. It makes heavy use of zinit's [turbo mode](https://zdharma-continuum.github.io/zinit/wiki/INTRODUCTION/#turbo_mode_zsh_53) to load plugins asynchronously, keeping shell startup lightning fast, with a warm interactive zsh startup time of approximately 30 ms.

[Powerlevel10k](https://github.com/romkatv/powerlevel10k)'s [instant prompt](https://github.com/romkatv/powerlevel10k#instant-prompt) is also enabled to display the prompt even faster. If you disable it in `.zshrc` when debugging, the configuration automatically disables zinit's turbo and light modes as well, to provide clearer output.

## Requirements

- git >= 2.25
- yadm >= 3.0
- zsh >= 5.3

## Installation

Your system `zshenv` should set:

```sh
ZDOTDIR=${XDG_CONFIG_HOME:-$HOME/.config}/zsh
```

Then clone with `yadm`:

```bash
yadm clone https://github.com/5A6F65/dotfiles.git
```

After cloning, the `post_clone` hook configures sparse-checkout so `README.md` and `LICENSE` are kept in the remote repository and not checked out into `$HOME`.

## License

BSD 3-Clause License. See [LICENSE](LICENSE).