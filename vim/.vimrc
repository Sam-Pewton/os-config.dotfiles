""" LINE NUMBERING
set number
set relativenumber " For relative line numbering..

""" SPACINGS
set tabstop=2 softtabstop=2
set shiftwidth=2
"set smartindent
"set smarttab " Autotabs for certain code
set foldlevel=99 " Default all folds to be unfolded on document open

""" HIGHLIGHTING
syntax on " Syntax highlighting
set showmatch " Shows matching brackets
set ruler " Always shows location in file
let &t_SI = "\e[1 q" " Cursor styling
let &t_EI = "\e[2 q"
hi MatchParen cterm=bold ctermbg=black ctermfg=DarkYellow
hi SignColumn guibg=black ctermbg=black ctermfg=black
hi Search cterm=NONE ctermbg=grey ctermfg=black
hi Visual cterm=NONE ctermbg=grey ctermfg=black
hi Folded cterm=NONE ctermbg=black
hi Error cterm=NONE ctermbg=red ctermfg=black
"set termguicolors

""" BUFFER MODIFICATIONS
set hidden
set nowrap
set scrolloff=8

""" SEARCHING
set incsearch

""" COLUMN
set signcolumn
set colorcolumn=80
highlight ColorColumn ctermbg=232

""" TERMINAL
set twsl
set history=1000

""" WINDOWS
set splitbelow
set splitright
set fdm=indent

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" PLUGINS
" Install vim-plug plugin manager if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

Plug 'gruvbox-community/gruvbox'
Plug 'ycm-core/YouCompleteMe' " Requires run of install.py from ~/.vim/plugged/YouCompleteMe/
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter' "BREAKS SYNTAX HIGHLIGHTING
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular' "Must come BEFORE vim-markdown
Plug 'preservim/vim-markdown'
Plug 'fs111/pydoc.vim'


call plug#end()

"colorscheme gruvbox
highlight Normal guibg=NONE

" let g:ycm_enable_semantic_highlighting=1
highlight Pmenu ctermfg=15 ctermbg=0 guifg=#ffffff guibg=#000000
let g:airline_theme='google_dark'
let g:airline#extensions#branch#enabled=1
let g:airline_powerline_fonts=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" KEYBINDS
map <F5> :NERDTree<CR>
map <F7> gg=G<C-o><C-o>
map <F8> :%s/\s\+$//e<CR>
map <F12> :vert term<CR>

