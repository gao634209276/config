let g:vim_home = '~/.config/nvim'
" === Install Plugins with Vim-Plug
" Default Plug Path
let g:vim_home = exists('g:vim_home') ? g:vim_home : '~/.config/nvim'
let g:vim_plug_path = g:vim_home.'/autoload/plug.vim'
let g:vim_plugged_path = g:vim_home.'/plugged'
if !filereadable(expand(g:vim_plug_path))
    let s:vim_plug_git = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    silent execute "!curl -fLo ".g:vim_plug_path." --create-dirs ".s:vim_plug_git
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(g:vim_plugged_path)
" Plug 'yianwillis/vimcdoc'

" File navigation
Plug 'preservim/nerdtree', { 'on' : [ 'NERDTreeToggle', 'NERDTreeClose', 'NERDTree' ] }
" Plug 'Xuyuanp/nerdtree-git-plugin', { 'on' : [ 'NERDTreeToggle', 'NERDTreeClose', 'NERDTree' ] }
" Plug 'phongvcao/nerdtree-yank-plugin', { 'on' : [ 'NERDTreeToggle', 'NERDTreeClose', 'NERDTree' ] }
Plug 'mbbill/undotree'
Plug 'vim-scripts/bufonly.vim'

"" Basic plugin
Plug 'mhinz/vim-startify'
Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/vim-solarized8'
" Plug 'vim-scripts/molokai'
" Plug 'sickill/vim-monokai'
" Plug 'tomasiser/vim-code-dark'

" BookMarks
" Plug 'MattesGroeger/vim-bookmarks'
Plug 'kshenoy/vim-signature'

" Status line
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" Git
Plug 'tpope/vim-fugitive'
" Plug 'junegunn/gv.vim'

Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim' " needed for previews

Plug 'jiangmiao/auto-pairs'
" Plug 'itchyny/vim-cursorword'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround' " type yskw' to wrap the word with '' or type cs'` to change 'word' to `word`

" Plug 'derekwyatt/vim-scala'
Plug 'skywind3000/asyncrun.vim'

" Tmux
Plug 'preservim/vimux'
if exists('$TMUX')
    Plug 'edkolev/tmuxline.vim'
    Plug 'christoomey/vim-tmux-navigator'
endif
if has('nvim') || version >= 800
    " auto complete
    " Plug 'Shougo/denite.nvim', { 'do': ':updateremoteplugins' }
    " Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }
    Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}}
    Plug 'antoinemadec/coc-fzf'
    Plug 'liuchengxu/vista.vim'
endif
call plug#end()

" === Defalult settings / keymap / plug settings
let s:source_path = fnamemodify(expand('<sfile>'), ':h')
execute 'source' s:source_path . '/base-settings.vim'
execute 'source' s:source_path . '/plug-settings.vim'
