"
" Personal preference .vimrc file
" Maintained by Bálint Kléri <balint@kleri.hu>
"

" Use vim settings, rather then vi settings
set nocompatible

" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Change the mapleader from \ to ,
let mapleader=","

" vimrc editing {{{
" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif
" }}}

" Editing behavior {{{
set showmode                    " always show what mode we're currently editing in
set tabstop=2                   " a tab is two spaces
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=2                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set ruler                       " always display the current cursor position in the lower right
                                "   corner of the Vim window
set showmatch                   " set show matching parenthesis
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
                                "    case-sensitive otherwise
set smarttab                    " insert tabs on the start of a line according to
                                "    shiftwidth, not tabstop
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set gdefault                    " search/replace "globally" (on a line) by default
set list                        " show the following invisible characters
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·

set pastetoggle=<F2>            " when in insert mode, press <F2> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
set mouse=a                     " enable using the mouse if terminal emulator
                                "    supports it (xterm does)
set fileformats="unix,dos,mac"
set formatoptions+=1            " When wrapping paragraphs, don't end lines
                                "    with 1-letter words
set laststatus=2                " tell VIM to always put a status line in, even
                                "    if there is only one window
set cmdheight=2                 " use a status bar that is 2 rows high
" }}}

" Folding rules {{{
set nofoldenable                " start out without any folding
set foldmethod=marker           " detect triple-{ style fold markers
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                " which commands trigger auto-unfold
" }}}

" Vim behaviour {{{
set nobackup                    " do not keep backup files
set noswapfile                  " do not write intermediate swap files,
set directory=~/.vim/tmp
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=list:full          " show a list when pressing tab and complete
                                "    first full match
set title                       " change the terminal's title
set visualbell                  " don't beep
set noerrorbells                " don't beep
" }}}

" Highlighting {{{
if &t_Co > 2 || has("gui_running")
   syntax on                    " switch syntax highlighting on, when the terminal has colors
endif
" }}}

" Shortcut mappings {{{

" Use the space button instead of : in normal mode
nmap <space> :

" Quickly close the current window
nnoremap <leader>q :q<CR>

" Quickly switch between my favorite light and dark color scheme.
nnoremap <leader>cl :color solarized<CR>:set background=light<CR>
nnoremap <leader>cd :color jellybeans<CR>:set background=dark<CR>

" Make p in Visual mode replace the selected text with the yank register
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Use the hjkl keys for moving around instead of the arrows
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap <leader>w <C-w>v<C-w>l

" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d

" Quick yanking to the end of the line
nmap Y y$

" Clears the search register
nmap <silent> <leader>/ :nohlsearch<CR>

" Pull word under cursor into LHS of a substitute (for quick search and
" replace)
nmap <leader>z :%s#\<<C-r>=expand("<cword>")<CR>\>#

" Keep search matches in the middle of the window and pulse the line when moving
" to them. This doesn't look so great in a non-GUI environment though.
if has("gui_running")
  nnoremap n n:call PulseCursorLine()<cr>
  nnoremap N N:call PulseCursorLine()<cr>
endif

" Quickly get out of insert mode without your fingers having to leave the
" home row (either use 'jj' or 'jk')
inoremap jj <Esc>
inoremap jk <Esc>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Jump to matching pairs easily, with Tab
nnoremap <Tab> %
vnoremap <Tab> %

" Strip all trailing whitespace from a file, using ,w
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>

" Reselect text that was just pasted with ,v
nnoremap <leader>v V`]

" Toggle Taglist window
nnoremap <leader>tt :TlistToggle<CR>

" }}}

" Conflict markers {{{
" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" shortcut to jump to next conflict marker
nmap <silent> <leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>
" }}}

" Filetype specific handling {{{
" only do this part when compiled with support for autocommands
if has("autocmd")
  " Handle Drupal php files.
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.inc set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
    autocmd BufRead,BufNewFile *.profile set filetype=php
  augroup END
endif
" }}}

" Language and autocompletion {{{
filetype plugin on
syntax on
set ofu=syntaxcomplete#Complete
" }}}

" PHP specific settings {{{
let php_baselib = 1
let php_parent_error_close = 1
let php_folding = 1
" }}}

" Appearance {{{
if has("gui_running")
  colorscheme solarized
  set cursorline
  set guifont=Monaco:h12
  set guioptions=egmrLt
  set guioptions-=L
else
    colorscheme Tomorrow-Night
    set bg=dark
endif
" }}}

" Plugin specific settings {{{

" Taglist
" The default ctags in /usr/bin on the Mac is GNU ctags, so change it to the
" exuberant ctags version in /usr/local/bin
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
" Quit when TagList is the last open window
let Tlist_Exit_OnlyWindow=1
" Enable the menu in GUI mode
let Tlist_Show_Menu=1
" Set the width of the Taglist window
let Tlist_WinWidth=40
" Settings for PHP
let tlist_php_settings='php;c:class;f:function'
" Process files even when the taglist window is not open
let Tlist_Process_File_Always=1
" Display the tags defined only in the current buffer
let Tlist_Show_One_File = 1
" }}}

" Load a tag file {{{
" Loads a tag file from ~/.vim.tags/, based on the argument provided. The
" command "Ltag"" is mapped to this function.
:function! LoadTags(file)
:   let tagspath = $HOME . "/.vim.tags/" . a:file
:   let tagcommand = 'set tags+=' . tagspath
:   execute tagcommand
:endfunction
:command! -nargs=1 Ltag :call LoadTags("<args>")
" }}}

" Pulse cursor line {{{
function! PulseCursorLine()
    let current_window = winnr()

    windo set nocursorline
    execute current_window . 'wincmd w'

    setlocal cursorline

    redir => old_hi
        silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    hi CursorLine guibg=#3a3a3a
    redraw
    sleep 20m

    hi CursorLine guibg=#4a4a4a
    redraw
    sleep 30m

    hi CursorLine guibg=#3a3a3a
    redraw
    sleep 30m

    hi CursorLine guibg=#2a2a2a
    redraw
    sleep 20m

    execute 'hi ' . old_hi

    windo set cursorline
    execute current_window . 'wincmd w'
endfunction

" }}}

