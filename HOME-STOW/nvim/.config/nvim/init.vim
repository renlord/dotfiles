set runtimepath+=~/.nvim,~/.nvim/after
set packpath+=~/.nvim
call plug#begin('~/.nvim/plugged')
" The following are examples of different formats supported.
" Keep Plug commands between vundle#begin/end.
" plugin on GitHub repo
Plug 'tpope/vim-fugitive'
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
Plug 'editorconfig/editorconfig-vim'
Plug 'Raimondi/delimitMate'
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdtree'
Plug 'git://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'pangloss/vim-javascript'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Chiel92/vim-autoformat'
Plug 'rust-lang/rust.vim'
Plug 'benmills/vimux'
Plug 'Shougo/deoplete.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tomlion/vim-solidity'
Plug 'ludovicchabant/vim-gutentags'
Plug 'lervag/vimtex'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
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

au BufRead,BufNewFile *.pp set filetype=puppet
au BufRead,BufNewFile Vagrantfile set filetype=ruby

function SetEnglishOptions()
    map ^T :w!<CR>:!aspell check %<CR>:e! %<CR>
endfunction
autocmd Filetype tex call SetEnglishOptions()
autocmd Filetype mail call SetEnglishOptions()

function SetRustOptions()
endfunction
autocmd Filetype rs call SetRustOptions()
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

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
let g:ale_linters = {
            \ 'javascript': ['xo'],
            \ }
let g:ale_fix_on_save = 1

" Javascript
let g:formatters_js = ['xo']
let g:jsx_ext_required = 1

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
