" Use vim defaults though they may override settings from the global vimrc
" (however it could protect these with skip_defaults_vim)
" source $VIMRUNTIME/defaults.vim
" let skip_defaults_vim=1

set nocompatible

" Basic configuration
syntax enable
set autoindent
set showmatch

set wildmenu

set guioptions-=T

set tabstop=4
set shiftwidth=4
set mouse=a

" Searching
set ignorecase
set smartcase
set incsearch
set hlsearch

" Key bindings
nnoremap <F7>	:tabp<CR>
nnoremap <F8>	:tabn<CR>
inoremap <F7>	<Esc>:tabp<CR>a
inoremap <F8>	<Esc>:tabn<CR>a

nnoremap <C-h>	:tabp<CR>
nnoremap <C-l>	:tabn<CR>
inoremap <C-h>	<Esc>:tabp<CR>a
inoremap <C-l>	<Esc>:tabn<CR>a

nnoremap <F12> :so $MYVIMRC<CR>
nnoremap <F2> :noh<CR>

" Update a tags file
nnoremap <F5> :!ctags -R .<CR>

" colorscheme elflord

nnoremap <F4>	viwc<C-r>0<Esc>

let g:LargeFile=10

filetype plugin on
filetype indent on

set fo=tcroqlj tw=80

" Cscope
cs a cscope.out

" Special support for different filetypes
" .vimrc
au bufwritepost .vimrc source %

" OCaml
au FileType ocaml setlocal expandtab fo-=t
set rtp+="/home/therb/.opam/4.06.1/share/ocp-indent/vim"

" Assembly
au FileType asm setlocal colorcolumn=80 fo-=t

" C, C++
au FileType c setlocal colorcolumn=80 cindent fo-=t
au FileType cpp setlocal colorcolumn=80 cindent fo-=t

" Python
au FileType python setlocal colorcolumn=80 fo-=t

" Markdown
au FileType markdown setlocal expandtab

" reStructuredText
au FileType rst setlocal tw=80
