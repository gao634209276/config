"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" === System
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" === Moure, Clipboard
set mouse=a
" set mouse-=a
" set mouse=n
" set mouse=nicr
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard^=unnamed,unnamedplus
" Clipboard Provider pb/tmux/osc52/local copy, and pb/tmux/local for paste
" === Colors and Fonts
set t_Co=16
if has("termguicolors")
    " Fix bug for vim
    " set t_8f=^[[38;2;%lu;%lu;%lum
    " set t_8b=^[[48;2;%lu;%lu;%lum
    " Enable true color
    set termguicolors
endif
set background=dark
try
    " For Lightline
    if has_key(g:plugs, 'vim-colors-solarized')
        colorscheme solarized
    endif
    " Plug 'lifepillar/vim-solarized8' needed
    if has_key(g:plugs, 'vim-solarized8')
        colorscheme solarized8_flat
        let g:solarized_use16 = 1
        let g:solarized_old_cursor_style = 1
    endif
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" === Vim user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ninimal number of screen lines to keep above and below the cursor
set scrolloff=5
" Language
" set langmenu=en_US.UTF-8
set langmenu=zh_CN.UTF-8
language messages zh_CN.UTF-8
language time en_US.UTF-8

" === Files, backups and undo
set nobackup
set nowritebackup
set noswapfile
if has('persistent_undo')
    silent !mkdir -p ~/.local/share/nvim/undo
    set undofile
    set undodir=~/.local/share/nvim/undo,.
endif
set viminfo='10,\"100,:20,%
if has('nvim')
    set viminfo+=n~/.local/share/nvim/shada/main.shada
else
    silent !mkdir -p ~/.local/share/vim
    set viminfo+=n~/.local/share/vim/viminfo
endif
" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime
" Restore cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" au BufRead,BufNewFile,BufEnter * cd %:p:h

" === Window, Buffers, StatusLine, CmdLine
set splitright splitbelow
set hidden
set showtabline=2
set showcmd
" set switchbuf=usetab,newtab
" Always show the status line
set laststatus=2
" set cmdheight=2
" Show cmd mode autocomplete wildmenu
set wildmode=longest,list,full
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc

" === Searching options
set hlsearch
set showmatch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" === Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Main code display
set number norelativenumber
set cursorline
" Indent behavior
set expandtab
set shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType cpp setlocal et sta sw=2 ts=2 sts=2
" Prevent auto line split
set textwidth=120
set indentexpr= autoindent smartindent
" Highlight tabs and trailing spaces
set list listchars=tab:▸\ ,trail:▫
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set foldmethod=indent
set foldlevel=99


" === leader
let mapleader = "\<space>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" === Basic Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fix keybind name for Ctrl+Space
map <Nul> <C-Space>
map! <Nul> <C-Space>

" === Save, Quit, Source
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>fw :w !sudo tee %<CR>
nnoremap <Leader>x :wq<CR>
" :W sudo saves the file
command! W w !sudo tee % > /dev/null
" Source vimrc
nnoremap <Leader>rc :source $MYVIMRC<CR>

" === Indent
nnoremap < <<
nnoremap > >>
vnoremap < <gv
vnoremap > >gv

" === Search & Replace
" Disabling the default s key
nnoremap s <Nop>
nnoremap S <Nop>
vnoremap s <Nop>
vnoremap S <Nop>
" C-n: move between matches without leaving incremental search
cnoremap <expr> <C-n> getcmdtype() == '/' \|\| getcmdtype() == '?' ? '<CR>/<C-r>/' : '<C-z>'
" Quick substitute within selected area
xnoremap sg :s//gc<Left><Left><Left>
nnoremap <silent> <Leader><CR> :nohlsearch<CR>
nnoremap s/ :<C-u>%s//g<Left><Left>
nnoremap <expr> s* ':<C-u>%s/\<' . expand('<cword>') . '\>//g<Left><Left>'
nnoremap <expr> sg ':<C-u>%s/' . expand('<cword>') . '//g<Left><Left>'
nnoremap s<Space> :<C-u>silent keeppatterns %substitute/\s\+$//e<CR>
" remove the windows ^M - when the encodings gets messed up
nnoremap sm mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm

" map si :set splitright<CR>:vsplit<CR>
" map sn :set nosplitright<CR>:vsplit<CR>
" map su :set nosplitbelow<CR>:split<CR>
" map se :set splitbelow<CR>:split<CR>

" Toggle fold
" Focus the current fold by closing all others
nnoremap <Leader>z zMzvzz

" === Cursor Movement
" Easier line-wise movement
noremap H g^
noremap L g$

" Location/quickfix list movement
nnoremap ]l :lnext<CR>
nnoremap [l :lprev<CR>
nnoremap ]c :cnext<CR>
nnoremap [c :cprev<CR>

vnoremap j gj
vnoremap k gk
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <S-Left>
cnoremap <C-w> <S-Right>
" Insert Mode Cursor Movement
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>
" Start new line fromk ny cursor position in insert-mode
inoremap <C-n> <C-o>o

" Clipboard
" Yank from cursor position to end-of-line
nnoremap Y y$
" Yank buffer's relative/absolute path to clipboard
nnoremap yp :let @+=expand("%:~:.")<CR>:echo 'Yanked relative path'<CR>
nnoremap yP :let @+=expand("%:p")<CR>:echo 'Yanked absolute path'<CR>
" toggle paste mode on and off
nnoremap <Leader>y :registers<CR>

" Buffer
" nnoremap <Leader>ba :bufdo bd<CR>
nnoremap <Leader>o :BufOnly<CR>
nnoremap <silent> <Leader>e :enew<CR>
nnoremap <silent> <Leader>d :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap <silent> <Leader>l :bnext<CR>
nnoremap <silent> <Leader>h :bprevious<CR>
nnoremap gb <C-^>
" nnoremap <Leader>ba :%bdelete<CR>
for s:i in range(1, 9)
execute 'nnoremap ' . s:i . 'gb :b' . s:i . '<CR>'
execute 'nnoremap <Leader>' . s:i . ' :b' . s:i . '<CR>'
endfor
map <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Window
nnoremap sv <C-w>v<C-w>l
nnoremap ss <C-w>s
nnoremap s- <C-w>-
nnoremap s\| <C-w>\|
nnoremap s= <C-w>=
nmap <C-j> <C-w>j
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l
nmap <C-k> <C-w>k
" Resize splits with arrow keys
map <S-up> :res +5<cr>
map <S-down> :res -5<cr>
map <S-left> :vertical resize-5<cr>
map <S-right> :vertical resize+5<cr>

" Tab Opcrations
" map <Leader>te :tabedit <C-r>=expand("%:p:h")<CR>/
map <silent> <m-e> :tabedit<CR>
map <silent> <m-o> :tabonly<CR>
map <silent> <m-m> :tabmove<CR>
map <silent> <Leader>te :tabedit<CR>
map <silent> <Leader>to :tabonly<CR>


" F3 toggle line number
" for mouse select and copy from terminal
function! HideNumber()
  if(&relativenumber)
    set relativenumber!
    if (&number)
      set number!
    endif
  else
    set number!
  endif
  set number?
endfunc
nnoremap <F3> :call HideNumber()<CR>
nnoremap <Leader>n :call HideNumber()<CR>
