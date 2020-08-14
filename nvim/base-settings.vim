" === System
" Mouse
set mouse-=a
" set mouse=a
" set mouse=nicr
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
set clipboard+=unnamedplus
" Clipboard provider for neovim
" if executable('clipboard-provider')
" Clipboard Provider pb/tmux/osc52/local copy, and pb/tmux/local for paste
let $COPY_PROVIDERS='local'
let $PASTE_PROVIDERS='local'
" TMUX support osc52, and tty not need user permissions for copy remote to local
if exists("$TMUX")
    " let $COPY_PROVIDERS='tmux osc52 local'
    " let $PASTE_PROVIDERS='tmux local'
    let $COPY_PROVIDERS='tmux osc52'
    let $PASTE_PROVIDERS='tmux'
endif
let g:clipboard = {
  \ 'name': 'myClipboard',
  \     'copy': {
  \         '+': 'clipboard-provider copy',
  \         '*': 'clipboard-provider copy',
  \     },
  \     'paste': {
  \         '+': 'clipboard-provider paste',
  \         '*': 'clipboard-provider paste',
  \     },
  \ }
" endif
" Colors
" set t_Co=256
" set t_Co=16
if has("termguicolors")
    " fix bug for vim
    set t_8f=^[[38;2;%lu;%lu;%lum
    set t_8b=^[[48;2;%lu;%lu;%lum
    " enable true color
    set termguicolors
endif
" Lang
" set langmenu=en_US.UTF-8
set langmenu=zh_CN.UTF-8
language messages zh_CN.UTF-8
language time zh_CN.UTF-8
set autoread

" === Main code display
set number norelativenumber
set cursorline
set ambiwidth=double

" === Editor behavior
set expandtab
set shiftwidth=4 tabstop=4 softtabstop=4
" Prevent auto line split
set textwidth=120
set indentexpr= autoindent smartindent
" Highlight tabs and trailing spaces
set list listchars=tab:▸\ ,trail:▫
set backspace=indent,eol,start
set foldmethod=indent
set foldlevel=99
if has('persistent_undo')
    silent !mkdir -p ~/.local/share/nvim/undo
    set undofile
    set undodir=~/.local/share/nvim/undo,.
endif
set viminfo='10,\"100,:20,%
if has('nvim')
    set viminfo+=n~/.local/share/nvim/shada/$OWNER.shada
else
    set viminfo+=n~/.viminfo
endif

" === window behaviors
set splitright splitbelow
" Format the status line
" set cmdheight=2
" Show cmd mode autocomplete wildmenu
" Show a navigable menu for tab completion
set wildmode=longest,list,full
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
" Searching options
set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase

" Ninimal number of screen lines to keep above and below the cursor
set scrolloff=5
" Auoto disable paste mode  when leave insert mode
" au InsertLeave * set nopaste
" Restore cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" au BufRead,BufNewFile,BufEnter * cd %:p:h
"
" === buf
" set switchbuf=usetab,newtab
set hidden
set showtabline=2

" === leader
let mapleader = "\<space>"

" === Basic Mappings
" Fix keybind name for Ctrl+Space
map <Nul> <C-Space>
map! <Nul> <C-Space>
nnoremap <m-q> q
nnoremap s <Nop>
nnoremap S <Nop>
vnoremap s <Nop>
vnoremap S <Nop>

" Save & quit
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>fw :w !sudo tee %<CR>
nnoremap <Leader>x :wq<CR>
" :W sudo saves the file
command! W w !sudo tee % > /dev/null
" Source vimrc
nnoremap <Leader>rc :source $MYVIMRC<CR>

" Indent
nnoremap < <<
nnoremap > >>
vnoremap < <gv
vnoremap > >gv

" Search & Replace
nnoremap <silent> <Leader><CR> :nohlsearch<CR>
" Quick substitute within selected area
xnoremap sg :s//gc<Left><Left><Left>
" C-n: move between matches without leaving incremental search
" cnoremap <expr> <C-w> getcmdtype() == '/' \|\| getcmdtype() == '?' ? '<CR>/<C-r>/' : '<C-z>'
" vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
" vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

nnoremap s/ :<C-u>%s//g<Left><Left>
nnoremap <expr> s* ':<C-u>%s/\<' . expand('<cword>') . '\>//g<Left><Left>'
nnoremap <expr> sg ':<C-u>%s/' . expand('<cword>') . '//g<Left><Left>'
nnoremap S/ :<C-u>%s//gc<Left><Left><Left>
nnoremap <expr> S* ':<C-u>%s/\<' . expand('<cword>') . '\>//gc<Left><Left><Left>'
nnoremap <expr> Sg ':<C-u>%s/' . expand('<cword>') . '//gc<Left><Left><Left>'
nnoremap ss :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>
" remove the windows ^M - when the encodings gets messed up
nnoremap sm mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm
" nnoremap <leader>g :execute "grep -R " . shellescape("<cWORD>") . " ."<cr>

" Disabling the default s key
" noremap s <nop>
" map si :set splitright<CR>:vsplit<CR>
" map sn :set nosplitright<CR>:vsplit<CR>
" map su :set nosplitbelow<CR>:split<CR>
" map se :set splitbelow<CR>:split<CR>

" Toggle fold
nnoremap <CR> za
nnoremap <Leader>, zc<CR>
nnoremap <Leader>. zo<CR>
" Focus the current fold by closing all others
nnoremap <Leader>z zMzvzz

" Cursor Movement
" Easier line-wise movement
nnoremap gh g^
nnoremap gl g$
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
" inoremap <C-b> <C-o>b
" inoremap <C-f> <C-o>f
" Start new line fromk ny cursor position in insert-mode
inoremap <C-n> <C-o>o

" Clipboard
" Yank from cursor position to end-of-line
nnoremap Y y$
" Yank buffer's relative/absolute path to clipboard
nnoremap yp :let @+=expand("%:~:.")<CR>:echo 'Yanked relative path'<CR>
nnoremap yP :let @+=expand("%:p")<CR>:echo 'Yanked absolute path'<CR>
" toggle paste mode on and off
" nnoremap <Leader>p :setlocal paste!<CR>
nnoremap <Leader>y :registers<CR>

" Buffer
" nnoremap <Leader>ba :bufdo bd<CR>
nnoremap <Leader>o :BufOnly<CR>
" nnoremap <Leader>bq :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap <silent> <Leader>d :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap gb <C-^>
nnoremap <silent> <Leader>l :bnext<CR>
nnoremap <silent> <Leader>h :bprevious<CR>
nnoremap <silent> <Leader>b :bn<CR>
nnoremap <silent> <Leader>B :bp<CR>
" nnoremap <Leader>ba :%bdelete<CR>
for s:i in range(1, 9)
execute 'nnoremap ' . s:i . 'gb :b' . s:i . '<CR>'
execute 'nnoremap <Leader>' . s:i . ' :b' . s:i . '<CR>'
endfor
map <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Window
nnoremap <leader>s <C-w>v<C-w>l
nnoremap <leader>i <C-w>s
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

