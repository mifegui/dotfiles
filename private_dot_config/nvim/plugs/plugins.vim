
" Instalar automaticamente o Plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin(stdpath('data') . '/plugged')       " Iniciar vim-plug, gerenciador de plugins
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }         " Vimwiki - Uma wiki para vim

Plug 'junegunn/goyo.vim'                            " Tela centralizada
Plug 'vim-airline/vim-airline'                      " Stausline melhor
Plug 'joshdick/onedark.vim'                         " Colorscheme

Plug 'farmergreg/vim-lastplace'                     " Vim-lastplace - Abrir arquivo de onde parou
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " FZF - FuzZy file Finder
Plug 'junegunn/fzf.vim'                             " FZF para o vim - Rapidamente abrir qualquer arquivo
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " CoC.nvim Vim IDE
Plug 'fatih/vim-go'                                 " Vim-go - Programr em golang
call plug#end()                                     " Finalizar vim-plug
