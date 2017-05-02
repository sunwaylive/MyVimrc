# 1 源码安装编辑器 vim
发行套件的软件源中预编译的 vim 要么不是最新版本，要么功能有阉割，有必要升级成全功能的最新版，当然，源码安装必须滴:  

```
git clone git@github.com:vim/vim.git<br>cd vim/  
./configure --with-features=huge --enable-pythoninterp --enable-rubyinterp --enable-luainterp --enable-perlinterp --with-python-config-dir=/usr/lib/python2.7/config/ --enable-gui=gtk2 --enable-cscope --prefix=/usr  
make    
make install 
```

其中，--enable-pythoninterp、--enable-rubyinterp、--enable-perlinterp、--enable-luainterp 等分别表示支持 ruby、python、perl、lua 编写的插件，--enable-gui=gtk2 表示生成采用 GNOME2 风格的 gvim，--enable-cscope 支持 cscope，--with-python-config-dir=/usr/lib/python2.7/config/ 指定 python 路径（先自行安装 python 的头文件 python-devel），这几个特性非常重要，影响后面各类插件的使用。注意，你得预先安装相关依赖库的头文件，python-devel、python3-devel、ruby-devel、lua-devel、libX11-devel、gtk-devel、gtk2-devel、gtk3-devel、ncurses-devel，如果缺失，源码构建过程虽不会报错，但最终生成的 vim 很可能缺失某些功能。构建完成后在 vim 中执行


```
:echo has('python')
```

若输出 1 则表示构建出的 vim 已支持 python，反之，0 则不支持。


# 2 配置插件
1. git clone https://github.com/sunwaylive/MyVimrc.git ~/ 

2. 安装ack， mac: brew install ack; linux: apt-get install ack.

3. 安装ycm， 这一步最复杂, 进入 ~/.vim/bundle/YouCompleteMe, 按照 https://github.com/Valloric/YouCompleteMe 的教程安装.

# 3 使用YCM

1. 到~/.vim/bundle/YCM-Generator目录下, 执行 ./config_gen.py ~/your_proj_dir_where_cmakelist_lies, more details: https://github.com/rdnetto/YCM-Generator

2. 到自己的项目的build目录下执行，cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=1 或者 在CMakeList.txt中加入: set(CMAKE_EXPORT_COMPILE_COMMANDS ON), 这样就会再build目录下生成compile_command.json. (more details: http://clang.llvm.org/docs/JSONCompilationDatabase.html)

3. 修改ycm_extra_conf.py 中的compilation_database_folder字段，database的路径 需要 使用绝对路径, 例如：/Users/sunwei/Workspace/caribean-fight-server/build

4. 打开工程中任意一个cpp， 执行 YcmRestartServer即可, <leader>j, 即可跳转





