" 
" My vimrc based on the ultimate vimrc by Amix - https://github.com/amix/vimrc
" 
"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " Sets how many lines of history VIM has to remember
 set history=500

 " Enable filetype plugins
 filetype plugin on
 filetype indent on

 " Set to auto read when a file is changed from the outside
 set autoread

 " With a map leader it's possible to do extra key combinations
 " like <leader>w saves the current file
 let mapleader = ","
 let g:mapleader = ","

 " Fast saving
 nmap <leader>w :w!<cr>

 " Map typos that happen often
command Q q
command Wq wq

 " :W sudo saves the file 
 " (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

set pastetoggle=<F3>

set nu

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

if has("win16") || has("win32")
     set wildignore+=.git\*,.hg\*,.svn\*
     else
         set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif


" Add a bit extra margin to the left
 set foldcolumn=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " Enable syntax highlighting
syntax enable 

 " Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
     set t_Co=256
endif

try
   colorscheme desert
   catch
endtry

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines



""""""""""""""""""""""""""""""
" => Visual mode related
" """"""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>




""""""""""""""""""""""""""""""
" => Status line
" """"""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c





"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
         call CmdLine("Ag '" . l:pattern . "' " )
    elseif a:direction == 'replace'
         call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"    Returns true if paste mode is enabled
 function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction
        
" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

   if bufnr("%") == l:currentBufNum
         new
   endif

   if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
   endif
 endfunction

 " Make VIM remember position in file after reopen
 " if has("autocmd")
 "   au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
 "endif




" Old stuffffff 
"filetype plugin indent on
"set nu
"
"" ----- Section pasted from some example config
"
"set background=light
"colorscheme solarized
"
"
"" Make Vim more useful
"set nocompatible
"" Use the OS clipboard by default (on versions compiled with `+clipboard`)
"" Enhance command-line completion
"set wildmenu
"" Allow cursor keys in insert mode
"set esckeys
"" Allow backspace in insert mode
"set backspace=indent,eol,start
"" Optimize for fast terminal connections
"set ttyfast
"" Add the g flag to search/replace by default
"set gdefault
"" Use UTF-8 without BOM
"set encoding=utf-8 nobomb
"" Change mapleader
"let mapleader=","
"" Don’t add empty newlines at the end of files
"set binary
"set noeol
"
"
"set viminfo+=! " make sure vim history works
"map <C-J> <C-W>j<C-W>_ " open and maximize the split below
"map <C-K> <C-W>k<C-W>_ " open and maximize the split above
"set wmh=0 " reduces splits to a single line 
"
"" Enable per-directory .vimrc files and disable unsafe commands in them
"set exrc
"set secure
"" Enable syntax highlighting
"syntax on
"" Highlight current line
"set cursorline
"" Make tabs as wide as two spaces
"set tabstop=2
"" Enable line numbers
"set number
"" Show “invisible” characters
""set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
""set list
"" Highlight searches
"set hlsearch
"" Ignore case of searches
"set ignorecase
"" Highlight dynamically as pattern is typed
"set incsearch
"" Always show status line
"set laststatus=2
"" Respect modeline in files
"set modeline
"set modelines=4
"" Enable mouse in all modes
"set mouse=a
"" Disable error bells
"set noerrorbells
"" Don’t reset cursor to start of line when moving around.
"set nostartofline
"" Show the cursor position
"set ruler
"" Don’t show the intro message when starting Vim
"set shortmess=atI
"" Show the current mode
"set showmode
"" Show the filename in the window titlebar
"set title
"" Show the (partial) command as it’s being typed
"set showcmd
"
"" Start scrolling three lines before the horizontal window border
"set scrolloff=3
"
"" Strip trailing whitespace (,ss)
"function! StripWhitespace()
"        let save_cursor = getpos(".")
"        let old_query = getreg('/')
"        :%s/\s\+$//e
"        call setpos('.', save_cursor)
"        call setreg('/', old_query)
"endfunction
"noremap <leader>ss :call StripWhitespace()<CR>
"" Save a file as root (,W)
"noremap <leader>W :w !sudo tee % > /dev/null<CR>
"
"" Automatic commands
"if has("autocmd")
"        " Enable file type detection
"        filetype on
"        " Treat .json files as .js
"        autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
"endif
"
"
"
