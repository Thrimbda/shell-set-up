# shell-set-up

my personal shell set up script.

it's basically a customed adaptation of **[oh-my-zsh](https://ohmyz.sh/)** install script.

usage:

```bash
# via curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Thrimbda/shell-set-up/master/install.sh)"

# via wget
sh -c "$(wget https://raw.githubusercontent.com/Thrimbda/shell-set-up/master/install.sh -O -)"
```

After which...Tada! And finally you will get this! Don't worry your old `.zshrc` would have a backup as `.zshrc.back`.(if you have one.)

![screen-shot](https://raw.githubusercontent.com/Thrimbda/shell-set-up/master/screen_shot.png)

if you want to adopt my configuration, you can replace `DEFAULT_USER` variable with your username in `.zshrc` and uncomment it if you want (default is `$USER@$HOSTNAME`).

finally, **Do remember install an powerline+awesome([nerd](https://github.com/ryanoasis/nerd-fonts)) font** (here is [meslo](https://raw.githubusercontent.com/Thrimbda/shell-set-up/master/font/Meslo%20LG%20M%20Regular%20Nerd%20Font%20Complete.otf) which I am using) to show all these wonderful stuff!

## TODO

- [ ] auto update check.
- [ ] update plugins and themes if new versions has been found (or freeze a set of versions when commit?)
- [ ] make transient prompt eazier to config, e.g. elements of retired prompt only, both retired and current prompt.
