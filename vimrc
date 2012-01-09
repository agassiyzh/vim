"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: Agassi Yu <agassi21@gmail.com>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

set history=400
if has('mouse')
	set mouse=a
endif
set backspace=indent,eol,start
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set incsearch " do incremental searching
set autoread
set iskeyword+='-'


"if &t_Co > 2 || has("gui_running")
syntax on
set hlsearch
"endif

filetype plugin indent on
set autoindent " always set autoindenting on
set smartindent
filetype plugin indent on

augroup vimrcEx
	au!
	autocmd FileType text setlocal textwidth=78
	autocmd BufReadPost *
				\ if line("'\"") > 1 && line("'\"") <= line("$") |
				\ exe "normal! g`\"" |
				\ endif
augroup END

if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif
set helplang=cn

" Platform
set formatoptions+=mM 
function! MySys()
	if has("win32") || has("win64")
		return "windows"
	elseif has("mac")
		return "mac"
	else
		return "linux"
	endif
endfunction

set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

" Move Backup Files to ~/.vim/backups/
set backupdir=~/.vim/backups
set dir=~/.vim/backups
set nobackup
"set nowritebackup

set undodir=~/.vim/undos
set undofile

""set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab
set nowrap
set wildmenu
set matchpairs+=(:),{:},[:],<:>
set whichwrap=b,s,<,>,[,]
set foldmethod=indent
set foldlevel=1
set diffopt+=iwhite,vertical " 忽略缩进的差异
"set cursorbind
set gdefault

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

colorscheme molokai
if has("gui_running") || has("gui_macvim")
	let g:colors_name="molokai"
	"	set t_Co=256
endif

if MySys() == "mac"
	set guifont=Menlo:h14
	set guifontwide=Hei_Regular:h13
elseif MySys() == "linux"
	set guifont=Monospace
endif

set anti
"set linespace=2
set cursorline
"当前行显示下划线。高亮当前行在一定程度上会影响 Vim 的性能，降低缓冲区更新速度
hi cursorline guibg=NONE gui=underline
"set number
set rnu
set numberwidth=4
set equalalways
set guitablabel=%t

set so=7
set cmdheight=2

set ignorecase "Ignore case when searching
set smartcase

set incsearch
set lazyredraw
set display=lastline
" 让编辑模式可以中文输入法下按：转到命令模式
nnoremap ： :
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let g:javascript_enable_domhtmlcss=1
"let g:xml_use_xhtml = 1 "for xml.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MacVim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("gui_macvim")

	"set columns=171
	"set lines=58
	"winpos 52 42

	let macvim_skip_cmd_opt_movement = 1
	let macvim_hig_shift_movement = 1

	"set transparency=9
	set guioptions-=T "egmrt
	set guioptions-=r
	set guioptions-=L
	"set guioptions+=b

	macm File.New\ Tab key=<D-T>
	macm File.Save<Tab>:w key=<D-s>
	macm File.Save\ As\.\.\.<Tab>:sav key=<D-S>
	macm Edit.Undo<Tab>u key=<D-z> action=undo:
	macm Edit.Redo<Tab>^R key=<D-Z> action=redo:
	macm Edit.Cut<Tab>"+x key=<D-x> action=cut:
	macm Edit.Copy<Tab>"+y key=<D-c> action=copy:
	macm Edit.Paste<Tab>"+gP key=<D-v> action=paste:
	macm Edit.Select\ All<Tab>ggVG key=<D-A> action=selectAll:
	macm Window.Toggle\ Full\ Screen\ Mode key=<D-F>
	macm Window.Select\ Next\ Tab key=<D-}>
	macm Window.Select\ Previous\ Tab key=<D-{>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" filetype
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd! bufwritepost .vimrc source ~/.vimrc
autocmd! bufwritepost vimrc source ~/.vimrc

if exists('+autochdir')
	set autochdir
else
	autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
endif


" filetype
autocmd BufNewFile,BufRead *.vm setlocal ft=html
autocmd BufNewFile,BufRead *.xul setlocal ft=xml
autocmd BufNewFile,BufRead *.as setlocal ft=actionscript
autocmd BufNewFile,BufRead *.json setlocal ft=javascript
autocmd BufNewFile,BufRead *.pac setlocal ft=javascript
autocmd BufNewFile,BufRead *.ypac setlocal ft=yaml


" language support
autocmd FileType javascript setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 textwidth=79
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType xml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType php setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" turn on omnicompletion
set ofu=syntaxcomplete#Complete
" Omni Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

"set noimd
"if has("gui_running")
"	set imactivatekey=C-space
"	inoremap <ESC> <ESC>:set iminsert=2<CR>
"endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map Q gq
inoremap <C-U> <C-G>u<C-U>

let mapleader=","
let g:mapleader=","

"map <leader>, ,

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
map <D-H> <C-h>
map <D-J> <C-j>
map <D-K> <C-k>
map <D-L> <C-l>

nnoremap <D-V> <C-w>v

" for YankRing
map <D-p> <C-p>
let g:yankring_history_dir = '~/.vim'

noremap <leader>ee :e ~/.vimrc<cr>

nmap <tab> v>
nmap <s-tab> v<
vmap <tab> >gv
vmap <s-tab> <gv

nnoremap / /\v
vnoremap / /\v


"inoremap <expr><CR> StructStart() ? '<CR><ESC>kA<CR>' : '<CR>'

" map cmd to ctrl
if has("gui_macvim")
	imap <D-c> <C-c> "快速结束插入模式
	map <D-y> <C-y>
	map <D-e> <C-e>
	map <D-f> <C-f>
	map <D-b> <C-b>
	map <D-u> <C-u>
	map <D-d> <C-d>
	map <D-w> <C-w>
	map <D-r> <C-r>
	map <D-o> <C-o>
	map <D-i> <C-i>
	map <D-g> <C-g>
	map <D-]> <C-]>
	cmap <D-d> <C-d>
	imap <D-e> <C-e>
	imap <D-y> <C-y>
endif

"移动长行
nnoremap <Down> gj
nnoremap <Up> gk

map <silent><A-Right> :bn<CR>
map <silent><A-Left> :bp<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugin setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" netrw setting
let g:netrw_winsize = 30
"nmap <silent> <leader>fe :Sexplore!<cr>

" NERDTree setting
nmap <silent> <leader>nt :NERDTree<cr>
let g:NERDTreeQuitOnOpen=1

nnoremap <silent> <leader>yr :YRShow<cr>
inoremap <silent> <c-r> <ESC>:YRShow<cr>

" showmarks
if has("gui_running") || has("gui_macvim")
	let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	let g:showmarks_enable = 1
	let showmarks_ignore_type = "hqm"
else
	let g:showmarks_enable = 0
endif

source /usr/local/share/vim/vim73/macros/matchit.vim


""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

"Git branch
function! GitBranch()
	try
		let branch = system("git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //'")
	catch
		return ''
	endtry

	if branch != ''
		return '   Git Branch: ' . substitute(branch, '\n', '', 'g')
	en

	return ''
endfunction

function! CurDir()
	return substitute(getcwd(), '/Users/Agassi/', "~/", "g")
endfunction

function! HasPaste()
	if &paste
		return 'PASTE MODE  '
	en
	return ''
endfunction

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L%{GitBranch()}
