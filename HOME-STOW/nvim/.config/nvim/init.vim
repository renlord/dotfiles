set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim

call plug#begin('~/.vim/plugged')
" The following are examples of different formats supported.
" Keep Plug commands between vundle#begin/end.
" plugin on GitHub repo

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
"Language Server Support -- lint, static analysis
Plug 'neovim/nvim-lspconfig'
"autocompletion: main one
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" 9000+ Snippets
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
" Git: wrapper inside vim
Plug 'tpope/vim-fugitive'
" Nice vimbar
Plug 'vim-airline/vim-airline'
" Reads .editorconfig to enforce developer editor styling
Plug 'editorconfig/editorconfig-vim'
" This plug-in provides automatic closing of quotes, parenthesis, brackets, etc
Plug 'Raimondi/delimitMate'
" Nicer colors
Plug 'flazz/vim-colorschemes'
" Nerdtree: file browser inside nvim
Plug 'scrooloose/nerdtree'
" Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
Plug 'ctrlpvim/ctrlp.vim'
" This plugin provides the following mappings which allow you to move between
" Vim panes and tmux splits seamlessly.
Plug 'alexghergh/nvim-tmux-navigation'
" Vimux: easily interact with tmux from vim
Plug 'benmills/vimux'
" VimTeX: is a modern Vim and Neovim filetype and syntax plugin for LaTeX files.
Plug 'lervag/vimtex'
" Jinja junk
Plug 'lepture/vim-jinja'
Plug 'vmware-archive/salt-vim'

Plug 'junegunn/fzf'
Plug 'morhetz/gruvbox'
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
set signcolumn=yes
syntax on

let s:uname = system("echo -n \"$(uname)\"")
if has("unix")
    if s:uname == "Linux"
        set clipboard+=unnamedplus
    endif
    if s:uname == "Darwin"
        set clipboard+=unnamed
    endif
endif

filetype plugin on

""""""""""""""""""""""""""""""""""""""""""""""""
" File-specific configurations
"
""""""""""""""""""""""""""""""""""""""""""""""""

function SetEnglishOptions()
    set spelllang=en_us
    map ^T :w!<CR>:!aspell check %<CR>:e! %<CR>
    hi clear SpellBad
    hi SpellBad cterm=underline
endfunction
autocmd Filetype tex call SetEnglishOptions()
autocmd Filetype mail call SetEnglishOptions()

" Email
au FileType mail let b:delimitMate_autoclose = 0

"""""""""""""""""""""""""""""""""""""""""""""""
" Keymaps
"
"""""""""""""""""""""""""""""""""""""""""""""""
noremap <PageUp> <NOP>
inoremap <PageUp> <NOP>
noremap <PageDown> <NOP>
inoremap <PageDown> <NOP>

" Use ctrl-[hjkl] to select the active split!
nnoremap <silent> <c-k> :wincmd k<CR>
nnoremap <silent> <c-j> :wincmd j<CR>
nnoremap <silent> <c-h> :wincmd h<CR>
nnoremap <silent> <c-l> :wincmd l<CR>

nnoremap j gj
nnoremap k gk
nnoremap <silent> <c-b> :CtrlPBuffer<CR>

nnoremap <leader>sv :source $MYVIMRC<CR>

" Leader
:let mapleader = ";"
:let maplocalleader = ";;"

 let g:tex_flavor = "latex"
"""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Configuration
"
"""""""""""""""""""""""""""""""""""""""""""""""
"Ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep --ignore=tags'
  map <C-f> :Ack<space>
endif

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1



" VimTex
let g:tex_flavor='latex'
let g:vimtex_view_method='open'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'
let g:vimtex_compiler_progname = 'nvr'

" Neosnippet key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
inoremap <C-k>     <Plug>(neosnippet_expand_or_jump)
snoremap <C-k>     <Plug>(neosnippet_expand_or_jump)
xnoremap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" NERDTree
map <C-n> :NERDTreeToggle<CR>

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
nnoremap <silent> ff :Goyo <CR>

" run gofmt for golang file
au BufWritePost *.go !gofmt -w %

" Rust.vim
let g:rustfmt_autosave = 1

" ctrlp settings
nnoremap <silent> <c-b> :CtrlPBuffer<CR>
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

lua <<EOF
-- Setup lspconfig
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

vim.g.coq_settings = {
  keymap = {
    recommended = false,
    jump_to_mark = '',
    pre_select = true,
  },
  auto_start = true,
  display = {
    pum = {
      fast_close = false
    }
  }
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['gopls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
}

require'nvim-tmux-navigation'.setup {
    disable_when_zoomed = true, -- defaults to false
    keybindings = {
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
        last_active = "<C-\\>",
        next = "<C-Space>",
    }
}


EOF

