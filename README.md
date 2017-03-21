# dotfiles
My own dotfiles and configs

## Installing

```bash
git clone https://github.com/arcz/dotfiles.git my_dir/dotfiles
cd my_dir/dotfiles
git submodule init
git submodule update
cd
ln -s .vim my_dir/dotfiles/.vim
ln -s .vimrc my_dir/dotfiles/.vimrc
ln -s .bashrc my_dir/dotfiles/.bashrc
ls -s .tmux.conf my_dir/dotfiles/.tmux.conf
vim +PluginInstall +qall
```
