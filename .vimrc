let mapleader = ' '

" plugins
let s:plug_path = expand('~/.vim/autoload/plug.vim')
if empty(glob(s:plug_path))
  silent execute '!curl -fLo ' . shellescape(s:plug_path) . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
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
      \ autoComplete: v:false,
      \ showSignature: v:false
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

function! s:ShowSignatureOnce() abort
  let b:lsp_signature_once = 1
  LspShowSignature
endfunction

nnoremap <silent> <leader>. :call ToggleNetrw()<CR>
nnoremap <leader>fa :Files<CR>
nnoremap <leader>fr :History<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fw :Rg <C-r><C-w><CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fh :Helptags<CR>
nnoremap <leader>fk :Maps<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>fz :BLines<CR>

nnoremap grn :LspRename<CR>
nnoremap grr :LspShowReferences<CR>
nnoremap gri :LspGotoImpl<CR>
nnoremap grt :LspGotoTypeDef<CR>
nnoremap gO :LspDocumentSymbol<CR>
nnoremap gD :LspGotoDeclaration<CR>
nnoremap gd :LspGotoDefinition<CR>
nnoremap K :LspHover<CR>
inoremap <silent> <C-s> <C-o>:call <SID>ShowSignatureOnce()<CR>

augroup LspSignatureOnce
  autocmd!
  autocmd InsertCharPre * if exists('b:lsp_signature_once') && b:lsp_signature_once | if exists('*popup_clear') | silent! call popup_clear() | endif | silent! pclose | unlet b:lsp_signature_once | endif
augroup END

" colors
silent! colorscheme iceberg
