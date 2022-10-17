# install file for vim conf
#
# requirement: vim latest version. if using OSX use macvim and make alias to use it
#
#!/bin/bash
echo "Installing vimrc in home directory"
cp vimrc ~/.vimrc
echo "Installing plugin in .vim folder under plugins filename"
cp plugins/plugins.vim ~/.vim/plugins.vim

echo " DONE. you have vim installed. not forget to install the plugins"


