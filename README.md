# Dotfiles

![visiblue](.screenshots/screenshot1.png)


### Clone dotfile bare reposity

```
echo 'alias dotfiles="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"' >> $HOME/.zshrc
source ~/.zshrc
echo "dotfiles" >> .gitignore
git clone --bare https://github.com/lepepe/dotfiles.git $HOME/dotfiles
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```
