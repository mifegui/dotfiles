" | Inteface | 
set hidden       " N precisa salvar pra poder mudar de buffer/arquivo
set expandtab    " Usar espaço em vez de tab
set shiftwidth=4 " Tamanho de um tab = 4 espaços
set tabstop=4    " Dividir tabs de 4 em 4 unidades
set softtabstop=4 " Backspace deleta um 'tab' inteiro
set ai           " Auto ident
set si           " Smart ident
set foldcolumn=0 " (Sem) Pequeno espaço na esquerda
set linebreak    " Quebrar entre palavras quando chegar no final da tela
set so=7         " 7 linhas pra baixo verticalmente, quando estiver descendo
set cmdheight=1  " Altura da barra lá embaixo (quão pra cima ela está)
set inccommand=nosplit " Mostrar substituições ao vivo
set noshowmode   " Não mostrar se está no modo inserção/normal/visual
set cursorline " Marcar linha atual

syntax on          " Ativar sintaxe para coisas

set laststatus=2 " Barra de status ativada sempre
" Format the status line
set statusline=
set statusline+=\ %l "Linha
set statusline+=\ %c "Coluna
set statusline+=\ %* "Espaço
set statusline+=\ ‹‹
set statusline+=\ %f "Caminho relativo
set statusline+=\ ››
set statusline+=\ %m "Estado (salvo, mudanças não salvas)
"set statusline+=\ %F " Caminho absoluto
set statusline+=%= "Separador esquerda direita
set statusline+=\ %y " Tipo do arquivo atual
"set statusline+=\ \[%{&fileformat}\] " Formato do arquivo atual
"set statusline+=\ ‹‹
"set statusline+=\ %{strftime('%H:%M')} "Hora e minuto com um : no meio"
"set statusline+=\ \| " |
"set statusline+=\ %{strftime('%d/%m')} "Dia e mes"
"set statusline+=\ ››\ %* "Separador com mais espaço
set statusline+=\ 

"| Arquivos |
filetype plugin indent on " Deixar plugins definirem arquivos como serem do tipo do próprio plugin
set nocompatible " Sem compatibilidade com coisas antigas
set autoread " Ler automaticamente arquivo se for mudado por fora
set nobackup " Sem backup
set noswapfile " Sem swapfile

set spelllang=pt,en_us " Linguagens para correção automática
set complete+=kspell " Autocompletar considerando dicionários quando em modo de spell check

" Refazer mudanças mesmo depois de ter saído do arquivo
try 
  set undodir=~/.cache/nvim/undodir/
  set undofile
catch
endtry

" | Misc |
" Mostrar idents com <leader>|
set list lcs=tab:\|·,trail:·

" Recarregar o init.vim quando salvar ele
autocmd! bufwritepost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim

" Esqueci de abrir com sudo
cmap w!! w !sudo tee %

command! BufOnly execute "%bd|e#|bd#"
