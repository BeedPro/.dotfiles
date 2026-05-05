" Basic Vim setup inspired by Tony's vanilla Vim workflow

" Core behavior
filetype plugin indent on
set expandtab
set background=dark
set shiftwidth=4
set softtabstop=4
set tabstop=4
set number
set relativenumber
set smartindent
set showmatch
set backspace=indent,eol,start
syntax on

" Leader key
let mapleader = ' '

" Toggle netrw with <leader>.
function! ToggleNetrw()
  for winnr in range(1, winnr('$'))
    if getbufvar(winbufnr(winnr), '&filetype') ==# 'netrw'
      bd
      return
    endif
  endfor
  Ex
endfunction

nnoremap <silent> <leader>. :call ToggleNetrw()<CR>

" vim-plug bootstrap
let s:plug_path = expand('~/.vim/autoload/plug.vim')
if empty(glob(s:plug_path))
  silent execute '!curl -fLo ' . shellescape(s:plug_path) . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'yegappan/lsp'
Plug 'cocopon/iceberg.vim'
call plug#end()

" Colorscheme
silent! colorscheme iceberg

" FZF keymaps
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fo :History<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fq :CList<CR>
nnoremap <leader>fh :Helptags<CR>
nnoremap <leader>fs :Rg <C-r><C-w><CR>
nnoremap <leader>fg :Rg<Space>
nnoremap <leader>fc :execute 'Rg ' . expand('%:t:r')<CR>
nnoremap <leader>fi :Files ~/.vim<CR>

" Built-in LSP plugin setup
let lspOpts = #{
      \ autoHighlightDiags: v:true,
      \ autoComplete: v:false
      \ }
autocmd User LspSetup call LspOptionsSet(lspOpts)

let lspServers = [
      \ #{
      \   name: 'ty',
      \   filetype: ['python'],
      \   path: 'ty',
      \   args: ['server']
      \ }
      \ ]

autocmd User LspSetup call LspAddServer(lspServers)

" LSP key mappings
nnoremap gd :LspGotoDefinition<CR>
nnoremap gr :LspShowReferences<CR>
nnoremap K :LspHover<CR>
nnoremap gl :LspDiag current<CR>
nnoremap <leader>nd :LspDiag next \| LspDiag current<CR>
nnoremap <leader>pd :LspDiag prev \| LspDiag current<CR>

" Set omnifunc for completion
autocmd FileType python setlocal omnifunc=lsp#complete

" ASCII diagnostic signs
autocmd User LspSetup call LspOptionsSet(#{
    \   diagSignErrorText: 'E',
    \   diagSignWarningText: 'W',
    \   diagSignInfoText: 'I',
    \   diagSignHintText: 'H',
    \ })
