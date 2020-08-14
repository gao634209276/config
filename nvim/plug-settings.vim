" plug settings
" === Vim-colors-solarized
if !has('nvim') && has_key(g:plugs, 'vim-colors-solarized')
    colorscheme solarized
endif
" === Vim-solarized8
if has('nvim') && has_key(g:plugs, 'vim-solarized8')
    colorscheme solarized8_flat
endif
let g:solarized_use16 = 1
let g:solarized_old_cursor_style = 1
" === Airline
" let g:airline_extensions = []
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#tab_nr_type = 0
" let g:airline#extensions#tagbar#enabled = 0
let g:airline_highlighting_cache=1
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1
" let g:airline_theme='solarized'
" let g:airline#extensions#tagbar#flags = 'f'
" let g:airline#extensions#tmuxline#enabled = 0
" === Llightline
let g:lightline = {
      \ 'colorscheme' : 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly' ],
      \             [ 'filename', 'diagnostic', 'modified' ]
      \    ]
      \ },
      \ 'component' : {
      \    'lineinfo': '%3l:%-2v%<'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'Lightlinegit',
      \   'diagnostic': 'LightlineDiagnostic',
      \   'filetype': 'LightlineFiletype',
      \   'fileformat': 'LightlineFileformat',
      \   'readonly': 'LightlineReadonly',
      \   'currentfunction'  : 'CocCurrentFunction',
      \   'mode'  : 'LightlineMode',
      \ },
      \ }
let g:lightline.mode_map       = {
        \ 'n' : 'N',
        \ 'i' : 'I',
        \ 'R' : 'R',
        \ 'v' : 'V',
        \ 'V' : 'VL',
        \ "\<C-v>": 'VB',
        \ 'c' : 'C',
        \ 's' : 'S',
        \ 'S' : 'SL',
        \ "\<C-s>": 'SB',
        \ 't': 'T',
        \ }

function! LightlineMode()
  return &filetype ==# 'vista' ? 'VISTA' :
        \ &filetype ==# 'nerdtree' ? 'NERD' :
        \ &filetype ==# 'fugitive' ? 'FUGITIVE' :
        \ &filetype ==# 'fzf' ? 'FZF' :
        \ lightline#mode()
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "RO"
  else
    return ""
  endif
endfunction

function! Lightlinegit()
  let l:branch = fugitive#head()
  return winwidth(0) > 70 ? (l:branch !=# '' ?  'ᚠ ' . l:branch : '') : ''
endfunction

" Dianostic, coc need
function! LightlineDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ')
endfunction
if has_key(g:plugs, 'lightline.vim')
    autocmd User CocDiagnosticChange call lightline#update()
    autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()
endif

" === Lightline-bufline
let g:lightline#bufferline#shorten_path      = 1
let g:lightline#bufferline#show_number       = 1
" let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#number_separator  = ' '
let g:lightline#bufferline#ordinal_separator = '|'
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#unnamed           = '[No Name]'
let g:lightline#bufferline#clickable         = 1

let g:lightline.tabline            = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_raw      = {'buffers': 1}
let g:lightline.component_expand   = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type     = {'buffers': 'tabsel', 'close': 'raw'}

" === NERDTree
nnoremap tt :NERDTreeToggle<CR>
nnoremap tu :UndotreeToggle<CR>
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F5> :UndotreeToggle<CR>

let g:NERDTreeWinSize=35
let g:NERDTreeShowBookmarks = 1
let g:nerdtreewinpos = "left"
let g:NERDTreeBookmarksFile = expand('$HOME/.local/share/nvim/NERDTreeBookmarks')
" nnoremap <expr> M ':<C-u>%s/\<' . expand('<cword>') . '\>//g<Left><Left>'
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" === Undotree
noremap tu :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
function g:Undotree_CustomMap()
    nmap <buffer> k <plug>UndotreeNextState
    nmap <buffer> j <plug>UndotreePreviousState
    nmap <buffer> K 5<plug>UndotreeNextState
    nmap <buffer> J 5<plug>UndotreePreviousState
endfunc

" === BookMark
let g:bookmark_no_default_key_mappings = 1
" nmap mt <Plug>BookmarkToggle
" nmap ma  <Plug>BookmarkAnnotate
" nmap ms <Plug>BookmarkShowAll
" nmap mj <Plug>BookmarkNext
" nmap mk <Plug>BookmarkPrev
" nmap mC <Plug>BookmarkClear
" nmap mX <Plug>BookmarkClearAll
" nmap mu <Plug>BookmarkMoveUp
" nmap me <Plug>BookmarkMoveDown
" nmap <Leader>g <Plug>BookmarkMoveToLine
" let g:bookmark_save_per_working_dir = 1
" let g:bookmark_auto_save = 1
" let g:bookmark_highlight_lines = 1
" let g:bookmark_manage_per_buffer = 1
" let g:bookmark_save_per_working_dir = 1
" let g:bookmark_center = 1
" let g:bookmark_auto_close = 1
" let g:bookmark_location_list = 1

" === Git
nnoremap <Leader>gd :Gdiffsplit!<CR>
let g:fugitive_no_maps = 1


" === Fzf
let g:fzf_preview_window = 'right:60%'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
" let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
" Files (runs $FZF_DEFAULT_COMMAND if defined)
nnoremap <C-p> :Files<CR>
nnoremap <Leader>ff :Files<CR>
" Open buffers
nnoremap <Leader>fb :Buffers<CR>
" v:oldfiles and open buffers
nnoremap <Leader>fh :History<CR>
" Lines in loaded buffers
nnoremap <Leader>fL :Lines<CR>
" Lines in the current buffer
nnoremap <Leader>fl :BLines<CR>
" Tags in the current buffer
nnoremap <Leader>fT :Tags<CR>
" Tags in the project (ctags -R)
nnoremap <Leader>ft :BTags<CR>
" find marks
nnoremap <Leader>fm :Marks<CR>
" Command history
nnoremap <Leader>f: :History:<CR>
" Search history
nnoremap <Leader>f/ :History/<CR>
" :Commands
nnoremap <Leader>fc :Commands<CR>
nnoremap <Leader>c :Colors<CR>
" find normal map key
nnoremap <Leader>fk :Maps<CR>
" Git files (git ls-files)
nnoremap <Leader>fg :GFiles<CR>
" Git commits (requires fugitive.vim)
nnoremap <Leader>gc :Commits<CR>
" Git commits for the current buffer
nnoremap <Leader>gb :BCommits<CR>
" Git files (git status)
nnoremap <Leader>gs :GFiles?<CR>

" === Tmux
let g:tmuxline_powerline_separators = 0
let g:tmuxline_theme = 'lightline'
" :Tmuxline lightline
" :TmuxlineSnapshot tmuxline.conf

if !has('nvim')
    finish
endif

" === Nvim
set completeopt=longest,noinsert,menuone,noselect,preview
" fix the most annoying bug that coc has
set hidden
set nobackup
set nowritebackup
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
" === Terminal Mode
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>

if exists(':tnoremap')
    tnoremap <Esc> <C-\><C-n>
endif

set pyxversion=2
let g:coc_node_path = '/opt/meituan/node/bin/node'
let g:python_host_prog  = '/opt/meituan/miniconda2/envs/python2.7/bin/python'
let g:python3_host_prog = '/opt/meituan/miniconda2/envs/python3/bin/python'
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1
" let g:loaded_python3_provider = 0
let g:loaded_ruby_provider = 0

" === Coc
silent! au BufEnter,BufRead,BufNewFile * silent! unmap if
autocmd FileType json syntax match Comment +\/\/.\+$+
            " \ 'coc-prettier',
            " "\ 'coc-fzf-preview',
let g:coc_global_extensions = [
            \ 'coc-css',
            \ 'coc-diagnostic',
            \ 'coc-explorer',
            \ 'coc-flutter-tools',
            \ 'coc-git',
            \ 'coc-gitignore',
            \ 'coc-html',
            \ 'coc-highlight',
            \ 'coc-json',
            \ 'coc-pairs',
            \ 'coc-python',
            \ 'coc-sh',
            \ 'coc-sql',
            \ 'coc-snippets',
            \ 'coc-syntax',
            \ 'coc-todolist',
            \ 'coc-tsserver',
            \ 'coc-vimlsp',
            \ 'coc-yaml',
            \ 'coc-yank']

" === Complete Suggest Trigger
" use <Tab> for trigger completion and navigate to the next complete item
inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
" close the preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" === Help/Document Trigger
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
" function args doc
nnoremap <silent> <Leader>k :call CocActionAsync('showSignatureHelp')<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" === Diagnostics quickfix
" Use `\d` get all diagnostics of current buffer in location list.
nnoremap <silent><nowait> \d :<C-u>CocList diagnostics<cr>
" Use `[d` and `]d` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')
if exists('*CocActionAsync')
    autocmd CursorHold * silent call CocActionAsync('highlight')
endif
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Explore
" nmap <leader>e :CocCommand explorer<CR>
nmap te :CocCommand explorer<CR>

" Statusline
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction
" let g:lightline.component_function.cocstatus = 'coc#status'
let g:lightline.component_function.currentfunction = 'CocCurrentFunction'

" Git
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gc <Plug>(coc-git-commit)
" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)
nnoremap <silent> \g  :<C-u>CocList --normal gstatus<CR>

" Symbol renaming.
nmap <Leader>rn <Plug>(coc-rename)
nmap <Leader>rf <Plug>(coc-refactor)

" === Format
" Formatting selected code.
xmap \f  <Plug>(coc-format-selected)
nmap \f  <Plug>(coc-format-selected)
nmap \ff  <Plug>(coc-format)
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<Leader>aap` for current paragraph
xmap <Leader>a  <Plug>(coc-codeaction-selected)
nmap <Leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <Leader>aa  <Plug>(coc-codeaction)

"kApply AutoFix to problem on the current line.
nmap <Leader>cf  <Plug>(coc-fix-current)


" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')
" Add `:Tsc` command for debug. see: https://github.com/neoclide/coc.nvim/wiki/Debug-coc.nvim
" command! -nargs=0 Tsc :call CocAction('runCommand', 'tsserver.watchBuild')


" add C for CocConfig
function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')

" Mappings for CoCList
" Manage extensions.
nnoremap <silent><nowait> \e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> \c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> \o  :<C-u>CocList outline<cr>
" Search workspace symbols. need Ctags
nnoremap <silent><nowait> \s  :<C-u>CocList -I symbols<cr> 
" Do default action for next item.
nnoremap <silent><nowait> ]c  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> [c  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> \l  :<C-u>CocListResume<CR>

" coc-fzf
" let g:coc_fzf_preview = ''
" let g:coc_fzf_opts = []
let g:coc_fzf_preview = exists('g:fzf_preview_window') ? g:fzf_preview_window : 'right:60%'
" let g:coc_fzf_opts = ['--layout=reverse-list']
let g:coc_fzf_opts = ['--layout=reverse']
nnoremap <silent> <Leader>fD :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent> <Leader>fd :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent> <Leader>fy :<C-u>CocFzfList yank<CR>
nnoremap <silent> <Leader>fl :<C-u>CocFzfList location<CR>
nnoremap <silent> <Leader>fs :<C-u>CocFzfList symbols<CR>
" Preview not Support
" nnoremap <silent> <Leader>fF :<C-u>CocFzfList<CR>
" nnoremap <silent> <Leader>fo :<C-u>CocFzfList outline<CR>
" nnoremap <silent> <Leader>fR :<C-u>CocFzfListResume<CR>

" coc-vista
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista#renderer#enable_icon = 0
let g:vista_default_executive = 'ctags'
" let g:vista_default_executive = 'coc'
" let g:vista_executive_for = { 'python': 'coc' }
" let g:vista_fzf_preview = ['right:60%']
" let g:vista_sidebar_width = 30

let g:vista_echo_cursor_strategy="floating_win"
" nnoremap <Leader>tv :Vista coc<CR>
nnoremap tv :Vista!!<CR>
nnoremap <Leader>fv :Vista finder lcn<CR>
