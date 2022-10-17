" vim config.
"
"

"
" memory commands
" zc = fold
" zo = open
" leader -s = git blame
" :bd -> close the file
" leader F -> run black machiato which run black for only selected lines
"
"
source ~/.vim/plugins.vim " load required plugins
let mapleader = ',' " leader key

set nocompatible
set number
set cursorline
set hlsearch  " highliths results
set ignorecase 
set noerrorbells
set belloff=esc

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set colorcolumn=89
set nowrap 
autocmd BufRead,BufNewFile *.md, *.txt setlocal wrap 
set noswapfile
set nobackup
set nowritebackup
set laststatus=2 "always show the status bar

set fileformat=unix
set encoding=utf-8
set fileencoding=utf-8


set showmatch
set splitright splitbelow



filetype plugin indent on
let python_highlight_all=1
syntax on


set termguicolors

let material_theme_enable=0
let space_vim_dark_enabled=1


" word movement
imap <S-Left> <Esc>bi
nmap <S-Left> b
imap <S-Right> <Esc><Right>wi
nmap <S-Right> w

" indent/unindent with tab/shift-tab
nmap <Tab> >>
imap <S-Tab> <Esc><<i
nmap <S-tab> <<
let g:neomake_python_enabled_makers = ['flake8']


" mouse
set mouse=a
let g:is_mouse_enabled = 1
noremap <silent> <Leader>m :call ToggleMouse()<CR>
function ToggleMouse()
    ifg:is_mouse_enabled == 1
        echo "Mouse OFF"
        set mouse=
        let g:is_mouse_enabled = 0
    else
        echo "Mouse ON"
        set mouse=a
        let g:is_mouse_enabled = 1
    endif
endfunction

" color scheme
"""" enable 24bit true color
"set t_Co=255
"set termguicolors

"""" enable the theme
syntax enable
set background=dark
"colorscheme space-vim-dark
"set termguicolors

"colorscheme everforest
"colorscheme onedar

syntax on
" set Vim-specific sequences for RGB colors


filetype on
filetype plugin indent on

" code folding
set foldmethod=indent
set foldlevel=99

" wrap toggle
setlocal nowrap
noremap <silent> <Leader>w :call ToggleWrap()<CR>
function ToggleWrap()
    if &wrap
        echo "Wrap OFF"
        setlocal nowrap
        set virtualedit=all
        silent! nunmap <buffer> <Up>
        silent! nunmap <buffer> <Home>
        silent! nunmap <buffer> <End>
        silent! iunmap <buffer> <Up>
        silent! iunmap <buffer> <Down>
        silent! iunmap <buffer> <Home>
        silent! iunmap <buffer> <End>
    else
        echo "Wrap ON"
        setlocal wrap linebreak nolist
        set virtualedit=
        setlocal display+=lastline
        noremap  <buffer> <silent> <Up>   gk
        noremap  <buffer> <silent> <Down> gj
        noremap  <buffer> <silent> <Home> g<Home>
        noremap  <buffer> <silent> <End>  g<End>
        inoremap <buffer> <silent> <Up>   <C-o>gk
        inoremap <buffer> <silent> <Down> <C-o>gj
        inoremap <buffer> <silent> <Home> <C-o>g<Home>
        inoremap <buffer> <silent> <End>  <C-o>g<End>
    endif
endfunction

" move through split windows
nmap <leader><Up> :wincmd k<CR>
nmap <leader><Down> :wincmd j<CR>
nmap <leader><Left> :wincmd h<CR>
nmap <leader><Right> :wincmd l<CR>

" move through buffers
nmap <leader>[ :bp!<CR>
nmap <leader>] :bn!<CR>
nmap <leader>x :bd<CR>

" restore place in file from previous session
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" file browser
let NERDTreeIgnore = ['\.pyc$', '_pycache_']
let NERDTreeMinimalUI = 1
let g:nerdtree_open = 0
map <C-k><C-k> :NERDTreeToggle<CR>
function NERDTreeToggle()
    NERDTreeTabsToggle
    if g:nerdtree_open == 1
        let g:nerdtree_open = 0
    else
        let g:nerdtree_open = 1
        wincmd p
    endif
endfunction

" tag list
map <leader>t :TagbarToggle<CR>

" copy, cut and paste
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" disable autoindent when pasting text
" source: https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

"let g:jedi#usages_command = "<leader>z"
"let g:jedi#popup_on_dot = 0
"let g:jedi#popup_select_first = 0
"let g:jedi#use_tabs_not_buffers = 1


" testing features
"let g:jedi#goto_command = "<leader>d"
"let g:jedi#goto_assignments_command = "<leader>g"
"let g:jedi#goto_stubs_command = "<leader>s"
"let g:jedi#goto_definitions_command = ""
"let g:jedi#documentation_command = "K"
"let g:jedi#usages_command = "<leader>n"
"let g:jedi#completions_command = "<C-Space>"
"let g:jedi#rename_command = "<leader>r"
"let g:jedi#popup_on_dot = 1


au BufReadPost,BufNewFile .py syntax match pythonFunction /\v([^[:cntrl:][:space:][:punct:][:digit:]]|)([^[:cntrl:][:punct:][:space:]]|)\ze(\s?\()/
" Disable because I have flake 8 in the ncoc
autocmd BufWritePost *.py call flake8#Flake8()


" VIM coc configs
" use <tab> for trigger completion and navigate to next complete item

set cmdheight=2
set updatetime=300

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction







" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"









inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif





" coc.nvim color changes
hi! link CocErrorSign WarningMsg
hi! link CocWarningSign Number
hi! link CocInfoSign Type

" === coc.nvim === "
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)

" FINAL COC CONFIS
"
" Config for Git BLAME
nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

let g:Tlist_Ctags_Cmd='/usr/local/Homebrew/Cellar/ctags/5.8_2/'
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END


nnoremap <C-p> :Files<CR>

" Plug macchiato config
autocmd FileType python xmap <buffer> <Leader>f <plug>(BlackMacchiatoSelection)
autocmd FileType python nmap <buffer> <Leader>f <plug>(BlackMacchiatoCurrentLine)
nnoremap  <s-f> :Ag<cr>

" config for task list warrior
"let g:vimwiki_list = [{'path': '/tmp/vimwiki', 'syntax':'markdown', 'ext': '.md'}]
"let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

let g:taskwiki_markup_syntax = 'markdown'

let g:mardown_folding = 1

""" config color for headers for wiki
:hi VimwikiHeader1 guifg=#fcc844
:hi VimwikiHeader2 guifg=#2fd65c
:hi VimwikiHeader3 guifg=#2fd6d1


" save file with leader key
noremap <Leader>s :update<CR>

" set cursor line
:hi cursorline cterm=none
:hi cursorlinenr ctermfg=red
if has('gui_running')
  set guifont=JetBrainsMonoNerdFontComplete-Regular:h13

endif


"""" SPACE VIM CONFIG THEME

if space_vim_dark_enabled
    colorscheme space-vim-dark
    "hi Normal     ctermbg=NONE guibg=NONE
    "hi LineNr     ctermbg=NONE guibg=NONE
    "hi SignColumn ctermbg=NONE guibg=NONE
    hi Comment cterm=italic
    let g:airline_theme='violet'
endif

"" GET FULL PATCH
nmap cp :let @" = expand("%")<cr>

let g:coc_global_extensions = [
    \ 'coc-tsserver',
    \ 'coc-json',
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-pyright',
    \ 'coc-diagnostic'
    \]

if material_theme_enable
    let g:airline_theme='material'
    let g:material_terminal_italics = 1
    colorscheme material
endif
