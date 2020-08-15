" === Support multi-user custom settings, and the settings is user-isolated
let $OWNER = empty($OWNER) ? 'sankuai' : $OWNER
let $HOME = '/home/sankuai'
if exists('$OWNER') && $OWNER != 'sankuai' && filereadable(expand('~/$OWNER/.config/nvim/init.vim'))
    " Reset Vim-Plug path for user
    let g:vim_home = '~/$OWNER/.config/nvim'
    if has('nvim')
        let &packpath = &runtimepath
        " Reset Coc path for user
        let g:coc_config_home = '~/$OWNER/.config/nvim'
        let g:coc_data_home = '~/$OWNER/.config/coc'
    endif
    " Source User init.vim if current script file is not
    if fnamemodify(expand('<sfile>'), ':p:~') !~ expand('$OWNER').'/.config/nvim/init.vim$'
        exec 'source' g:vim_home.'/init.vim'
        finish
    endif
    " Reset runtimepath for user
    set runtimepath-=~/.config/nvim
    set runtimepath-=~/.config/nvim/after
    set runtimepath^=~/$OWNER/.config/nvim
    set runtimepath+=~/$OWNER/.config/nvim/after
endif

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
Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/vim-solarized8'
" Plug 'vim-scripts/molokai'
" Plug 'sickill/vim-monokai'
" Plug 'tomasiser/vim-code-dark'
" Status line
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

" File navigation
Plug 'preservim/nerdtree', { 'on' : [ 'NERDTreeToggle', 'NERDTreeClose', 'NERDTree' ] }
" Plug 'Xuyuanp/nerdtree-git-plugin', { 'on' : [ 'NERDTreeToggle', 'NERDTreeClose', 'NERDTree' ] }
" Plug 'phongvcao/nerdtree-yank-plugin', { 'on' : [ 'NERDTreeToggle', 'NERDTreeClose', 'NERDTree' ] }
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim' " needed for previews
" Plug 'MattesGroeger/vim-bookmarks'

Plug 'mbbill/undotree'
Plug 'vim-scripts/bufonly.vim'
" Git
Plug 'tpope/vim-fugitive'
" Plug 'junegunn/gv.vim'
" Plug 'airblade/vim-gitgutter'

" Plug 'jiangmiao/auto-pairs'
" Plug 'itchyny/vim-cursorword'
" Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround' " type yskw' to wrap the word with '' or type cs'` to change 'word' to `word`

" Plug 'derekwyatt/vim-scala'

" Tmux
if exists('$TMUX')
    Plug 'edkolev/tmuxline.vim'
    Plug 'christoomey/vim-tmux-navigator'
endif
if has('nvim')
    " auto complete
    " Plug 'Shougo/denite.nvim', { 'do': ':updateremoteplugins' }
    " Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'antoinemadec/coc-fzf'
    Plug 'liuchengxu/vista.vim'
endif
call plug#end()

" === Defalult settings / keymap / plug settings
let s:source_path = fnamemodify(expand('<sfile>'), ':h')
execute 'source' s:source_path . '/base-settings.vim'
execute 'source' s:source_path . '/plug-settings.vim'
