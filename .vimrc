let mapleader = ' '

" plugins
let s:plug_path = expand('~/.vim/autoload/plug.vim')
if empty(glob(s:plug_path))
  silent execute '!curl -fLo ' . shellescape(s:plug_path) . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'yegappan/lsp'
Plug 'cocopon/iceberg.vim'
Plug 'machakann/vim-highlightedyank'
call plug#end()

let g:highlightedyank_highlight_duration = 200

let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment']
      \ }

" options
filetype plugin indent on
syntax on

set background=dark
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set number
set relativenumber
set hlsearch
set incsearch
set smartindent
set showmatch
set backspace=indent,eol,start

" lsp
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

autocmd FileType python setlocal omnifunc=lsp#complete

autocmd User LspSetup call LspOptionsSet(#{
    \ diagSignErrorText: 'E',
    \ diagSignWarningText: 'W',
    \ diagSignInfoText: 'I',
    \ diagSignHintText: 'H',
    \ })

" keybinds
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
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fo :History<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fq :CList<CR>
nnoremap <leader>fh :Helptags<CR>
nnoremap <leader>fs :Rg <C-r><C-w><CR>
nnoremap <leader>fg :Rg<Space>
nnoremap <leader>fc :execute 'Rg ' . expand('%:t:r')<CR>
nnoremap <leader>fi :Files ~/.vim<CR>
nnoremap gd :LspGotoDefinition<CR>
nnoremap grr :LspShowReferences<CR>
nnoremap K :LspHover<CR>

" colors
silent! colorscheme iceberg
