set number                     " Show current line number
set relativenumber             " Show relative line numbers
set tabstop=2
syntax on
set autoindent

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" fuzzy finding
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'preservim/nerdtree'

Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'machakann/vim-highlightedyank'


" List ends here. Plugins become visible to Vim after this call.
call plug#end()

