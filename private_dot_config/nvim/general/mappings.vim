
let g:mapleader =  "\<Space>"  " Definir espaço como leader
"
" Salvar rapidamente com Espaço Espaço
nmap <leader><leader> :w<cr>
"
" Pressione <leader> q para sair
nmap <leader>q :q<cr>
"
" Esconder highligh (e telinha lá embaixo) quando apertar leader enter
map <leader><cr> :noh<cr>:echo <cr>

" Feche o buffer atual com leader d 
map <silent><leader>d :bd<cr>
" Para o buffer anterior
map <silent><leader>l :bp<cr>
" Para o próximo buffer
map <silent><leader>h :bn<cr>
" Para o último buffer usado
map <silent><leader># :b#<cr>

" Mover entre janelas com ctrl-j em vez de ctrl-w-j
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Remapear o 0 para o primeiro caractere que não seja espaço
" Você pode usar o "|" como alternativa pro 0
" Mais, falando nisso, "gm", coloca o cursor no meio da tela, horizontalmente
map 0 ^

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
"
" Editar init.vim apertando leader e
map <leader>e :e! ~/.config/nvim/init.vim<cr>

vmap <leader>y "+y

" Habilitar e desabilitar spell checking com leader s
nmap <silent><leader>s :set spell!<cr>

" Remover ^M do windows 
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Deletar outros buffers (impl. em settings.vim)
nmap <leader>D :BufOnly<cr> 

" Mostrar trailing espaços e tabs e ademais
nnoremap <silent><leader>\| :set list!<cr>

nmap <leader>Oo :Open %<cr>
nmap <leader>Op :Open %:p:h<cr>

nmap <leader>tp :TafProj<cr>

