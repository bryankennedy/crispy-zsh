# Best-Bash to ZSH
Moving my [Bash scripts](https://github.com/bryankennedy/best-bash) to ZSH

# Install
## Overview
Start by installing [ Oh My Zsh ](http://ohmyz.sh/)
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

### Get this theme and set it up
```
cd /usr/local/src
git clone https://github.com/bryankennedy/crispy-zsh.git
cd crispy-zsh
git submodule init
git submodule update
ln -s /usr/local/src/crispy-zsh/pure/pure.zsh /usr/local/share/zsh/site-functions/prompt_pure_setup
ln -s /usr/local/src/crispy-zsh/pure/async.zsh /usr/local/share/zsh/site-functions/async
ln -s /usr/local/src/crispy-zsh/crispy.zsh-theme ~/.oh-my-zsh/custom/themes/crispy.zsh-theme
```

### Set crispy as your theme
Edit your `~/.zshrc` file changing the `ZSH_THEME` variable to crispy.

* Symlink the crispy theme into Oh My Zsh
* Set crispy as the theme
