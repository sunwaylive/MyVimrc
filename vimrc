set nocompatible
set sessionoptions-=options
filetype off
execute pathogen#infect()
syntax on

set fileencodings=utf-8,gb2312,gbk,gb18030
set fileencoding=utf-8
set termencoding=utf-8
set encoding=utf-8
set ff=unix
set fileformats=unix

"call pathogen#runtime_append_all_bundles()
"#call pathogen#infect('bundle/{}', '~/.vim/bundle/{}')
"call pathogen#helptags()
"call pathogen#infect()

filetype on
syntax enable
filetype plugin on
filetype plugin indent on


"tab
""set tags+=.,./**/tags,/data/home/kevinlin/trunk/tags,/data/home/kevinlin/trunk/snslib/api_tags,/data/home/kevinlin/trunk/snslib/comm_tags,/data/home/kevinlin/trunk/ext/tcm_tags
set tags+=.,./**/tags,/data/home/kevinlin/tags
"set tags+=.,./**/tags,/data/home/kevinlin/ML_20141013Guest/tags,/data/home/kevinlin/trunk/snslib/api_tags,/data/home/kevinlin/trunk/snslib/comm_tags,/data/home/kevinlin/trunk/ext/tcm_tags


set tabstop=4
set shiftwidth=4
set expandtab

set autoread
set ruler
set showcmd
set showmatch
set vb t_vb=
set softtabstop=4
set autoindent
set smartindent
set cindent
set nu
set nowrapscan
set hlsearch
set undolevels=5000
set noic   "设置区分大小写



"下面这些是网上抄下来的
""colorscheme elflord          " 着色模式
colorscheme desert          " 着色模式
""colorscheme slate          " 着色模式
set guifont=Monaco:h10       " 字体 && 字号
set tabstop=4                " 设置tab键的宽度
set shiftwidth=4             " 换行时行间交错使用4个空格
set autoindent               " 自动对齐
set backspace=2              " 设置退格键可用
set cindent shiftwidth=4     " 自动缩进4空格
set smartindent              " 智能自动缩进
set ai!                      " 设置自动缩进
set nu!                      " 显示行号
"set showmatch               " 显示括号配对情况
"set mouse=a                  " 启用鼠标
set ruler                    " 右下角显示光标位置的状态行
set incsearch                " 查找book时，当输入/b时会自动找到
set hlsearch                 " 开启高亮显示结果
hi IncSearch term=reverse cterm=NONE ctermfg=0 ctermbg=3
hi Search term=reverse cterm=NONE ctermfg=0 ctermbg=3
set incsearch                " 开启实时搜索功能
set nowrapscan               " 搜索到文件两端时不重新搜索
set nocompatible             " 关闭兼容模式
set vb t_vb=                 " 关闭提示音
"set cursorline              " 突出显示当前行
set hidden                   " 允许在有未保存的修改时切换缓冲区
"set list                     " 显示Tab符，使用一高亮竖线代替
"set listchars=tab:\|\ ,

syntax enable                " 打开语法高亮
syntax on                    " 开启文件类型侦测
filetype indent on           " 针对不同的文件类型采用不同的缩进格式
filetype plugin on           " 针对不同的文件类型加载对应的插件
filetype plugin indent on    " 启用自动补全

set writebackup              " 设置无备份文件
set nobackup
set autochdir                " 设定文件浏览器目录为当前目录
"set nowrap                  " 设置不自动换行
set foldmethod=syntax        " 选择代码折叠类型
set foldlevel=100            " 禁止自动折叠

set laststatus=2             " 开启状态栏信息
set statusline=%-10.3n      "buffer number
set cmdheight=2              " 命令行的高度，默认为1，这里设为2

" 每行超过80个的字符用下划线标示
au BufRead,BufNewFile *.asm,*.c,*.cpp,*.java,*.cs,*.sh,*.lua,*.pl,*.pm,*.py,*.rb,*.erb,*.hs,*.vim 2match Underlined /.\%81v/

au BufRead,BufNewFile *.proto setfiletype proto

" ======= 引号 && 括号自动匹配 ======= "

:inoremap ( ()<ESC>i

:inoremap ) <c-r>=ClosePair(')')<CR>

:inoremap { {}<ESC>i

:inoremap } <c-r>=ClosePair('}')<CR>

:inoremap [ []<ESC>i

:inoremap ] <c-r>=ClosePair(']')<CR>

":inoremap < <><ESC>i
	
":inoremap > <c-r>=ClosePair('>')<CR>

:inoremap " ""<ESC>i

:inoremap ' ''<ESC>i

:inoremap ` ``<ESC>i

function ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf


" TxtBrowser          高亮TXT文本文件
au BufRead,BufNewFile *.txt setlocal ft=txt

" :FencView           查看文件编码和更改文件编码
let g:fencview_autodetect=1

" :LoadTemplate       根据文件后缀自动加载模板
""let g:template_path='/data/kevinlin/.vim/template/'

" :AuthorInfoDetect   自动添加作者、时间等信息，本质是NERD_commenter && authorinfo的结合
let g:vimrc_author='kevinlin'
let g:vimrc_email='linjiang1205@qq.com'

" Ctrl + E            一步加载语法模板和作者、时间信息 [非插入模式]
""map <c-e> <ESC>:LoadTemplate<CR><ESC>:AuthorInfoDetect<CR><ESC>Gi
""vmap <c-e> <ESC>:LoadTemplate<CR><ESC>:AuthorInfoDetect<CR><ESC>Gi
map <c-e> <ESC>:AuthorInfoDetect<CR><ESC>


"easymotion
"=====================================
"let g:EasyMotion_do_mapping = 0 " Disable default mappings"
let g:EasyMotion_leader_key = '<Space>'
" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
map s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
""nmap s <Plug>(easymotion-s2)
""map t <Plug>(easymotion-t2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 0

" JK motions: Line motions
"map <Leader>j <Plug>(easymotion-j)
"map <Leader>k <Plug>(easymotion-k)
" search
map // <Plug>(easymotion-sn)
omap // <Plug>(easymotion-tn)



"设置mapleader
let mapleader=","
let g:mapleader=","


nnoremap <silent> <Leader>t :TlistToggle <CR>
""nnoremap <silent> <Leader>g :CommandT <CR>
nnoremap <silent> <Leader>g :CtrlPMixed <CR>
"nnoremap <silent> <Leader>w  :WMToggle <CR>
nnoremap <silent> <Leader>n  :NERDTreeToggle <CR>
"设置一些快捷键
"nnoremap <silent> <F8> :TlistToggle<CR>
"nmap <silent> <F7> :WMToggle <cr>
"nmap <silent> <F9> :NERDTreeToggle <cr>

"powerline{
set guifont=PowerlineSymbols\ for\ Powerline
set nocompatible
set t_Co=256
set encoding=utf8
""let g:Powerline_symbols = 'fancy'
""set fillchars+=stl:\ ,stlnc:\
"}

"Tlist
"taglist{
let Tlist_Ctags_Cmd='/usr/bin/ctags'
let Tlist_Auto_Open=0
let Tlist_Use_Right_Window=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Close_On_Select=0
let Tlist_Process_File_Always=1
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
"}

"winManager 
""let g:winManagerWindowLayout="FileExplorer"
""let g:winManagerWindowLayout = "TagList|FileExplorer,BufExplorer"
""let g:winManagerWidth = 30

"NERDTree{
let NERDChristmasTree=1
let NERDTreeAutoCenter=1
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=0
let NERDTreeShowLineNumbers=1
let NERDTreeWinPos='left'
let NERDTreeWinSize=40
let NERDTreeIgnore=['\.vim$', '\~$', '\.o$', '\.d$', '\.a$', '\.beam$']
"}

"minibufexp
let g:miniBufExplMapWindowNavVim=1 
let g:miniBufExplMapWindowNavArrows=1 
let g:miniBufExplMapCTabSwitchBufs=1 
let g:miniBufExplModSelTarget=1 
let g:miniBufExplorerMoreThanOne=0


"grep.vim
let Grep_Default_Options="-i"
let Grep_Default_Filelist="*.cpp *.h"
"let Grep_Xargs_Options='-print0'
""let Egrep_Path="/bin/egrep"
""let Fgrep_Path="/bin/fgrep"
""let Grep_Path="/bin/grep"
nnoremap <silent> <F5> :Grep<CR>

"ctrlp.vim
let g:ctrlp_by_filename = 0 
let g:ctrlp_regexp = 0 
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_lazy_update = 1 
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = $HOME.'/.vim/.cache/ctrlp'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_depth = 20
"set wildignore+=*/.git/*,*/.hg/*,*/.svn/* 
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll|a|o)$',
    \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
    \ }


"xml.vim"
let g:xml_syntax_folding = 1


" ctags 索引文件 (根据已经生成的索引文件添加即可, 这里我额外添加了 hge 和 curl 的索引文件) 
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1 
let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表 
let OmniCpp_MayCompleteDot = 1   " 输入 .  后自动补全
let OmniCpp_MayCompleteArrow = 1 " 输入 -> 后自动补全 
let OmniCpp_MayCompleteScope = 1 " 输入 :: 后自动补全 
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" 自动关闭补全窗口 
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif 
set completeopt=menuone,menu,longest



"clang_complete{
""let completeopt-=preview
"let g:clang_complete_auto = 1
"" clang_complete 相关
""产生错误时打开 quickfix 窗口
"let g:clang_complete_copen = 1
""定期更新 quickfix 窗口
"let g:clang_periodic_quickfix = 1
""开启 code snippets 功能
"let g:clang_snippets = 0
"}

"vmap "+y :w !pbcopy<CR><CR>
"nmap "+p :r !pbpaste<CR><CR>

"粘贴时不置换“剪贴板”
xnoremap p pgvy

nmap w= :resize +3<CR>
nmap w- :resize -3<CR>
nmap w, :vertical resize -3<CR>
nmap w. :vertical resize +3<CR>

hi Search term=reverse ctermfg=0 ctermbg=3
hi Todo     term=standout ctermbg=DarkRed ctermfg=White guibg=Red guifg=White

iab xtime <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>

