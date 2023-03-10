# A Python venv switcher for zsh

This is a minimal script that helps you switch between Python virtual environments. It recursively searches for a `venv` or `.venv` directory in the current directory and all its parents. If it finds one, it activates it. If it doesn't find one, it deactivates the current virtual environment.

It also contains `mkvenv` command that creates a new virtual environment in the current directory, activates it, and installs dependencies form `requirements.txt` if it exists.

The script contains minimal functionality on purpose to keep it simple and easy to understand. If you want more features, you can use [zsh-autoswitch-virtualenv](https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv).

## Installation

```sh
curl -o ~/.venv.zsh https://raw.githubusercontent.com/not-poma/venv-switcher/master/venv.zsh
echo "[[ -f ~/.venv.zsh ]] && source ~/.venv.zsh" >> ~/.zshrc
```

Restart your shell or run `source ~/.venv.zsh` to apply the changes