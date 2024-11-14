"-------------------------------------------------------------------------------
" @link         http://kenijo.github.io/WSH/
" @description  Custom Dircolors
" @license      MIT License
"-------------------------------------------------------------------------------

" Set colorscheme
let $THEME = "nord"

" Upgrade vim-plug
"   Terminal: vim -c "PlugUpgrade" -c "qa"

" Install vim-plug plugins
"   Terminal: vim -c "PlugInstall" -c "qa"

" Update vim-plug plugins
"   Terminal: vim -c "PlugUpdate" -c "qa"

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent!curl - fLo ~/.vim/autoload / plug.vim--create - dirs
\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g: plugs), '!isdirectory(v:val.dir)'))
\| PlugInstall--sync | source $MYVIMRC | : q
\| endif

call plug#begin()
" List your plugins here
    Plug 'sheerun/vim-polyglot'     " A collection of language packs for Vim
    Plug 'itchyny/lightline.vim'    " A light and configurable statusline/tabline plugin for Vim
    Plug 'phanviet/vim-monokai-pro' " Theme Monokai Pro
    Plug 'nordtheme/vim'            " Theme Nord
call plug#end()

" We prepend any command that should be loaded after plug#end() with 'silent!'
" to ignore errors when it's not yet installed.

" Turn on line number
"set number

" Manage identation
set tabstop = 4       " Size of a hard tabstop (ts).
set shiftwidth = 4    " Size of an indentation (sw).
set expandtab       " Always uses spaces instead of tab characters (et).
set softtabstop = 0   " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
set smarttab        " Inserts blanks on a <Tab> key (as per sw, ts and sts).
set autoindent      " Copy indent from current line when starting a new line.
set smartindent     " Reacts to the syntax/style of the code you are editing

" Set colorscheme
silent! colorscheme $THEME

" Enable LightLine
silent! let g: lightline = { 'colorscheme': $THEME }
set laststatus = 2
