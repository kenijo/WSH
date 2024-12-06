"-------------------------------------------------------------------------------
" @link         http://kenijo.github.io/WSH/
" @description  Script executed when starting vim
" @license      MIT License
"-------------------------------------------------------------------------------

" Set colorscheme
let $THEME="<WSH_THEME>"

" Install VIM Nord theme
if empty(glob('~/.vim/colors/nord.vim'))
    silent !curl -s -fLo ~/.vim/colors/nord.vim --create-dirs
        \ https://raw.githubusercontent.com/arcticicestudio/nord-vim/main/colors/nord.vim
endif

" Install VIM Monolai Pro theme
if empty(glob('~/.vim/colors/monokai_pro.vim'))
    silent !curl -s -fLo ~/.vim/colors/monokai_pro.vim --create-dirs
        \ https://raw.githubusercontent.com/phanviet/vim-monokai-pro/refs/heads/master/colors/monokai_pro.vim
endif

" Install VIM Lightline plugin
if empty(glob('~/.vim/plugins/lightline.vim'))
    silent !curl -s -fLo ~/.vim/plugins/lightline.vim --create-dirs
        \ https://raw.githubusercontent.com/itchyny/lightline.vim/refs/heads/master/plugin/lightline.vim
endif

" Install VIM Polyglot plugin
if empty(glob('~/.vim/plugins/polyglot.vim'))
    silent !curl -s -fLo ~/.vim/plugins/polyglot.vim --create-dirs
        \ https://raw.githubusercontent.com/sheerun/vim-polyglot/refs/heads/master/plugin/polyglot.vim
endif

" Turn on line number
"set number

" Manage identation
set tabstop=4           " Size of a hard tabstop (ts).
set shiftwidth=4        " Size of an indentation (sw).
set expandtab           " Always uses spaces instead of tab characters (et).
set softtabstop=0       " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
set smarttab            " Inserts blanks on a <Tab> key (as per sw, ts and sts).
set autoindent          " Copy indent from current line when starting a new line.
set smartindent         " Reacts to the syntax/style of the code you are editing

" Set colorscheme
colorscheme $THEME

" Enable LightLine
let g:lightline = { 'colorscheme': $THEME }
set laststatus=2

" Set Nord Theme configuration (https://www.nordtheme.com/docs/ports/vim/configuration)
let g:nord_cursor_line_number_background = 1
let g:nord_uniform_diff_background = 1
