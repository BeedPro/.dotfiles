let mapleader = ' '

set nocompatible
filetype plugin indent on
syntax on

let s:data_dir = '~/.vim'
if empty(glob(s:data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo ' . s:data_dir . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

set background=dark
set laststatus=2
set noshowmode
set clipboard=
set cursorline
set expandtab
set autoindent
set smartindent
set shiftwidth=2
set tabstop=2
set softtabstop=2
set ignorecase
set smartcase
set mouse=a
set number
set relativenumber
set numberwidth=2
set noruler
set signcolumn=yes
set splitbelow
set splitright
set timeoutlen=400
set undofile
set foldmethod=indent
set foldlevel=99
set foldtext=substitute(getline(v:foldstart),'/*\|*/\|{{{\d\=','','g')
set updatetime=250
set fillchars=eob:\ 
set guicursor=
set shortmess+=sI
set nowrap
set whichwrap+=<,>,[,],h,l

let g:fzf_layout = { 'window': { 'width': 0.87, 'height': 0.80 } }

command! -bang -nargs=? FilesAll call fzf#vim#files(
      \ <q-args>,
      \ {'source': 'rg --files --hidden --follow --glob "!.git/*"'},
      \ <bang>0)

nnoremap <silent> <leader>fa :FilesAll<CR>
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fw :Rg<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>fh :Helptags<CR>
nnoremap <silent> <leader>fm :Marks<CR>
nnoremap <silent> <leader>fz :BLines<CR>

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number | set relativenumber | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &number | set norelativenumber | endif
augroup END

function! s:is_django_project(filepath) abort
  let l:dir = fnamemodify(a:filepath, ':p:h')
  while !empty(l:dir) && l:dir !=# '/'
    if filereadable(l:dir . '/manage.py')
      return 1
    endif
    if filereadable(l:dir . '/project/settings.py')
      return 1
    endif
    if !empty(glob(l:dir . '/**/settings.py'))
      return 1
    endif

    let l:parent = fnamemodify(l:dir, ':h')
    if l:parent ==# l:dir
      break
    endif
    let l:dir = l:parent
  endwhile
  return 0
endfunction

function! s:html_looks_like_django(filepath) abort
  if !filereadable(a:filepath)
    return 0
  endif

  for l:line in readfile(a:filepath, '', 20)
    if l:line =~# '{%' || l:line =~# '{{' || l:line =~# '{#'
      return 1
    endif
  endfor

  return 0
endfunction

function! s:open_binary_with_system(file) abort
  if has('macunix')
    let l:open_cmd = 'open'
  elseif has('win32') || has('win64')
    let l:open_cmd = 'start'
  else
    let l:open_cmd = 'xdg-open'
  endif

  call jobstart([l:open_cmd, a:file], {'detach': v:true})
  silent! bdelete!
endfunction

augroup filetype_migration
  autocmd!
  autocmd BufRead,BufNewFile *.html if <SID>is_django_project(expand('<afile>:p')) || expand('<afile>:p') =~# '/templates/' || <SID>html_looks_like_django(expand('<afile>:p')) | setfiletype htmldjango | else | setfiletype html | endif
  autocmd BufReadPost *.pdf,*.png,*.jpg,*.jpeg,*.gif,*.bmp,*.svg,*.xopp call <SID>open_binary_with_system(expand('%:p'))
  autocmd FileType markdown setlocal conceallevel=2
  autocmd FileType cpp,cs setlocal shiftwidth=4 tabstop=4
  autocmd FileType html setlocal tabstop=2 shiftwidth=2 expandtab
  autocmd FileType python setlocal colorcolumn=80
  autocmd FileType typst setlocal spell spelllang=en_gb colorcolumn=80
augroup END
