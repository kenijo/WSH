"-------------------------------------------------------------------------------
" @link         http://kenijo.github.io/WSH/
" @description  Script executed when starting vim
" @license      MIT License
"-------------------------------------------------------------------------------

" Install VIM Lightline plugin
if empty(glob('~/.vim/plugin/lightline.vim'))
    silent !wget -q -O tmp.tar.gz - https://github.com/itchyny/lightline.vim/archive/master.tar.gz
    silent !tar -xf tmp.tar.gz --strip=2 'lightline.vim-master/autoload' --one-top-level='.vim/autoload'
    silent !tar -xf tmp.tar.gz --strip=2 'lightline.vim-master/plugin' --one-top-level='.vim/plugin'
    silent !rm -f tmp.tar.gz
    silent !clear
endif

" Install VIM Monokai Pro theme
if empty(glob('~/.vim/colors/monokai_pro.vim'))
    silent !wget -q -O tmp.tar.gz - https://github.com/phanviet/vim-monokai-pro/archive/master.tar.gz
    silent !tar -xf tmp.tar.gz --strip=2 'vim-monokai-pro-master/autoload' --one-top-level='.vim/autoload'
    silent !tar -xf tmp.tar.gz --strip=2 'vim-monokai-pro-master/colors' --one-top-level='.vim/colors'
    silent !rm -f tmp.tar.gz
    silent !clear
endif

" Install VIM Nord theme
if empty(glob('~/.vim/colors/nord.vim'))
    silent !wget -q -O tmp.tar.gz - https://github.com/nordtheme/vim/archive/master.tar.gz
    silent !tar -xf tmp.tar.gz --strip=2 'vim-main/autoload' --one-top-level='.vim/autoload'
    silent !tar -xf tmp.tar.gz --strip=2 'vim-main/colors' --one-top-level='.vim/colors'
    silent !rm -f tmp.tar.gz
    silent !clear
endif

" Install VIM OneDark theme
if empty(glob('~/.vim/colors/onedark.vim'))
    silent !wget -q -O tmp.tar.gz - https://github.com/joshdick/onedark.vim/archive/master.tar.gz
    silent !tar -xf tmp.tar.gz --strip=2 'onedark.vim-main/autoload' --one-top-level='.vim/autoload'
    silent !tar -xf tmp.tar.gz --strip=2 'onedark.vim-main/colors' --one-top-level='.vim/colors'
    silent !rm -f tmp.tar.gz
    silent !clear
endif

"-------------------------------------------------------------------------------

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

" Enable LightLine
set laststatus=2
set noshowmode
let g:lightline = { 'colorscheme': 'monokai_pro' }

" Set Nord Theme configuration (https://www.nordtheme.com/docs/ports/vim/configuration)
let g:nord_bold = 1
let g:nord_cursor_line_number_background = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
let g:nord_uniform_diff_background = 1

" Set OneDark Theme configuration (https://github.com/joshdick/onedark.vim)
let g:onedark_terminal_italics = 1

" Set colorscheme
syntax on
set termguicolors
colorscheme monokai_pro
