set runtimepath+=~/.nvim,~/.nvim/after
set packpath+=~/.nvim

call plug#begin('~/.nvim/plugged')
" The following are examples of different formats supported.
" Keep Plug commands between vundle#begin/end.
" plugin on GitHub repo
if has('nvim')
    Plug 'Shougo/deoplete.nvim', {'do': 'UpdateRemotePlugins'} 
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
" Duoplete Misc. Language Extensions
Plug 'sebastianmarkow/deoplete-rust'

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'editorconfig/editorconfig-vim'
Plug 'Raimondi/delimitMate'
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdtree'
Plug 'git://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'pangloss/vim-javascript'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Chiel92/vim-autoformat'
Plug 'benmills/vimux'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tomlion/vim-solidity'
Plug 'ludovicchabant/vim-gutentags'
Plug 'lervag/vimtex'
Plug 'junegunn/fzf'
Plug 'morhetz/gruvbox'
Plug 'dhruvasagar/vim-table-mode'
Plug 'mileszs/ack.vim'
Plug 'junegunn/goyo.vim'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""
" Colourscheme settings
"
""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme gruvbox
let g:gruvbox_contrast_dark = "dark"
""""""""""""""""""""""""""""""""""""""""""""""""""

set shell=/bin/bash
set backspace=indent,eol,start
set ts=4
set sw=4
set expandtab
syntax on
set foldmethod=syntax
set laststatus=1
set autoread
set wildmenu
set number
set list
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪
" ignore case match when searching in current file
set ic
" continuously search for tag file up to HOME
set tags=tags;~/

let s:uname = system("echo -n \"$(uname)\"")
if has("unix")
    if s:uname == "Linux"
        set clipboard=unnamedplus
    endif
    if s:uname == "Darwin"
        set clipboard+=unnamed
    endif
endif

filetype plugin on
set omnifunc=syntaxcomplete#Complete

""""""""""""""""""""""""""""""""""""""""""""""""
" File-specific configurations
"
""""""""""""""""""""""""""""""""""""""""""""""""

function SetEnglishOptions()
    map ^T :w!<CR>:!aspell check %<CR>:e! %<CR>
endfunction
autocmd Filetype tex call SetEnglishOptions()
autocmd Filetype mail call SetEnglishOptions()

"""""""""""""""""""""""""""""""""""""""""""""""
" Keymaps
"
"""""""""""""""""""""""""""""""""""""""""""""""
noremap <PageUp> <NOP>
inoremap <PageUp> <NOP>
noremap <PageDown> <NOP>
inoremap <PageDown> <NOP>

nnoremap j gj
nnoremap k gk
nnoremap <c-s-b> :CtrlPBuffer<CR>

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Leader
:let mapleader = ";"
:let maplocalleader = ";;"

 let g:tex_flavor = "latex"
"""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Configuration
"
"""""""""""""""""""""""""""""""""""""""""""""""
" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Duoplete
let g:deoplete#enable_at_startup = 1

" ALE
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'rust': ['analyzer', 'rls'],
\}

nnoremap <Leader>t :ALESymbolSearch
nnoremap <Leader>d :ALEGoToDefinition <CR>
nnoremap <Leader>r :ALEFindReferences <CR>


" Email
au FileType mail let b:delimitMate_autoclose = 0

" VimTex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'
let g:vimtex_compiler_progname = 'nvr'

" Neosnippet key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
let g:neosnippet#snippets_directory='~/.nvim/bundle/vim-snippets/snippets'
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" For conceal markers.
"if has('conceal')
"  set conceallevel=2 concealcursor=niv
"endif

" NERDTree
map <C-n> :NERDTreeToggle<CR>

"let g:LanguageClient_serverCommands = {
"    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
"    \ 'cpp': ['clangd'],
"    \ 'c': ['clangd'],
"    \ 'python': ['/usr/local/bin/pyls'],
"    \ }
"let g:LanguageClient_serverStderr = '/tmp/language-client-nvim.stderr'

"Ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep --ignore=tags'
  map <C-f> :Ack<space>
endif

set signcolumn=yes

"Gutentags
let g:gutentags_define_advanced_commands=1

" Goyo config
let g:goyo_width=120
let g:goyo_height="100%"
let g:goyo_linenr=1

function! s:goyo_enter()
  "if executable('tmux') && strlen($TMUX)
  "  silent !tmux set status off
  "  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  "endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
  " ...
endfunction

function! s:goyo_leave()
  "if executable('tmux') && strlen($TMUX)
  "  silent !tmux set status on
  "  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  "endif
  set showmode
  set showcmd
  set scrolloff=5
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Rust.vim 
let g:rustfmt_autosave = 1
