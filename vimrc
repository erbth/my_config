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
set guioptions-=m

set tabstop=4
set shiftwidth=4
set mouse=a

" Searching
set ignorecase
set smartcase
set incsearch
set hlsearch

" Key bindings
nnoremap <C-h>	:tabp<CR>
nnoremap <C-l>	:tabn<CR>
inoremap <C-h>	<Esc>:tabp<CR>a
inoremap <C-l>	<Esc>:tabn<CR>a

nnoremap <F12> :so $MYVIMRC<CR>
nnoremap <F2> :noh<CR>

" Update a tags file
nnoremap <F5> :!ctags -R .<CR>

if &term == "screen.xterm-256color"
	set bg=dark
endif

colorscheme elflord

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
au FileType asm setlocal colorcolumn=81 fo-=t

" C, C++
au FileType c setlocal colorcolumn=81 cindent fo-=t
au FileType cpp setlocal colorcolumn=81 cindent fo-=t

" cmake
au FileType cmake setlocal colorcolumn=81 fo-=t

" Python
au FileType python setlocal colorcolumn=80 tw=79 fo-=t

" Markdown
au FileType markdown setlocal expandtab colorcolumn=80 tw=79

" reStructuredText
au FileType rst setlocal colorcolumn=81

" LaTeX
au FileType tex setlocal colorcolumn=81

" JSON
au FileType json setlocal ts=2 sw=2

" call plug#begin()
" 	Plug 'preservim/nerdtree'
" 	Plug 'Xuyuanp/nerdtree-git-plugin'
" 	Plug 'ryanoasis/vim-devicons'
" 	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" 	Plug 'davidhalter/jedi-vim'
" 	Plug 'tpope/vim-fugitive'
" call plug#end()
" 
" nnoremap <C-n> :NERDTreeMirror<CR>:NERDTreeFocus<CR>
" 
" let g:jedi#popup_select_first = 0
" let g:jedi#popup_on_dot = 0
" let g:jedi#show_call_signatures = 0
