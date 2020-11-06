" vim:tabstop=2:shiftwidth=2:expandtab:textwidth=99

" ------------------- Mapas das Teclas ---------------------------------------
let g:mapleader =  "\<Space>"  " Definir espaço como leader
" Salvar rapidamente com Espaço Espaço
nmap <leader><leader> :w<cr>
" Pressione <leader> q para sair
nmap <leader>q :q<cr>
" Esconder highligh (e telinha lá embaixo) quando apertar leader enter
map <leader><cr> :noh<cr>:echo <cr>

" Feche o buffer atual com leader d 
map <silent><leader>d :bd<cr>
" Para o buffer anterior
map <silent><leader>l :bp<cr>
" Para o próximo buffer
map <silent><leader>h :bn<cr>
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
" % Nome do arquivo atual
map <leader>cd :cd %:p:h<cr>:pwd<cr>
"
" Editar init.vim apertando leader e
map <leader>e :e! ~/.config/nvim/init.vim<cr>
" Recarregar o init.vim quando salvar ele
autocmd! bufwritepost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim

" Habilitar e desabilitar spell checking com leader s
nmap <silent><leader>s :set spell!<cr>

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

command! BufOnly execute "%bd|e#|bd#"
nmap <leader>D :BufOnly<cr>
command! CDirWiki execute ":cd ".expand(vimwiki_list[0].path)
nmap <leader>cC :CDirWiki<cr>:pwd<cr>

" Mostrar idents com <leader>|
set list lcs=tab:\|·,trail:·
nnoremap <silent><leader>\| :set list!<cr>

" ------------------ Inteface Gráfica ----------------------------------------
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

filetype plugin indent on " Deixar plugins definirem arquivos como serem do tipo do próprio plugin
syntax on          " Ativar sintaxe para coisas

"set laststatus=2 " Ativar barra lá de baixo, statusbar
set laststatus=2 " Desativar barra lá de baixo, statusbar
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

" --------------------- Arquivos ---------------------------------------------
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

function! OpenFile(path)
  silent exec "!wsl-open '".a:path."'"
endfunction

command! -nargs=* Open call OpenFile(<q-args>)
" -------------- Plug Gerenciador de Plugins ---------------------------------
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

" -------------------------- Vimwiki/Wiki  ----------------------------------
" Todas essas coisas em :help vimwiki
" path: Caminho para wiki
" index: Nome do arquivo inical da wiki
" diary_rel_path: Caminho relativo para a pasta de diários
" diary_index: Caminho relativo (a partir da vravel anterior) para o index
" diary_header: Título do índice
" diary_caption_level: Nível dos títulos q serão mostrados no índice
" syntax: Sintaxe da wiki
" links_space_char: Separador entre os nomes dos arquivos da wiki 
" 	Ex: O novo jogo -> O_novo_jogo
" ext: Extensão dos arquivos da wiki
let g:wiki = {}
let wiki.path = '$LC' " Variável de ambiente
let wiki.index = 'Entrada/Entrada'
let wiki.diary_rel_path = 'Áreas/Jornal/'
let wiki.diary_index = 'Jornal'
let wiki.diary_header = 'FON'
let wiki.diary_caption_level = 0
let wiki.syntax = 'markdown'
let wiki.links_space_char = '-'
let wiki.ext = '.md'
let g:vimwiki_list = [wiki]

" Desabilitar ler arquivos de extensão .md fora do diretório wiki como se
" fossem outras wikis
let g:vimwiki_global_ext = 0

" Símbolos para mostrar progresso de todo lists
let g:vimwiki_listsyms = '✗○◐●✓'

" Esconder formatações de códigos
let g:vimwiki_conceal_pre = 1

" Nomes dos meses 
let g:vimwiki_diary_months = {
      \ 1: 'Janeiro', 2: 'Fevereiro', 3: 'Março',
      \ 4: 'Abril', 5: 'Maio', 6: 'Junho',
      \ 7: 'Julho', 8: 'Agosto', 9: 'Setembro',
      \ 10: 'Outubro', 11: 'Novembro', 12: 'Dezembro'
      \ }

" Nome da tabela de conteúdos
let g:vimwiki_toc_header = 'Conteúdo'

" Nome dos links gerados automaticamente
let g:vimwiki_links_header = 'Subcousas'

" Cabeçalho gerado automaticamente (1 = #, 2 = ##, 3 = ###)
" (pode ser 0)
let g:vimwiki_auto_header = 1

" Salvar automaticamente arquivo quando sair dele; n funciona individualmente 
" com o set hidden mas, se vc sair do vim, ele salva tudo.
let g:vimwiki_autowriteall = 1

" Remapear ir pro próximo link pra <Leader>n
nmap <Leader>n <Plug>VimwikiNextLink
nmap <Leader>N <Plug>VimwikiPrevLink

" Manejar os links de forma a permitir acessar quaisquer arquivos de qualquer
" lugar da wiki. Ou seja, assume-se que todos tenham nomes únicos e procura
" por eles.
" Usa: Fd para achar o arquivo
function! VimwikiLinkHandler(link)
  try
    let result = system('fdfind -F -e .md '.
          \ shellescape(a:link)." ".
          \ shellescape(expand(g:vimwiki_list[0].path)))
    if !len(l:result)
      return 0
    endif
    let result = split(l:result, '\n',)[0]  "Se tiver mais de um
    execute "edit " l:result
    return 1
  catch
    echo "Erro no link Handler"
  endtry
  return 0
endfunction


" Recebe um caminho (pode ser do fzf) e printa, no cursor, um link para esse
" arquivo
function! PasteWikiLink(path)
  " Testa se estiver vazio
  if !len(a:path) 
    echomsg("No path given")
    return
  endif
  " Nome do arquivo, expand pra deixar espaços
  let formatted=expand(fnamemodify(a:path, ':t:r'))
  let linkFormat = "[[" . l:formatted . "]]"
  " deleta todas as aspas
  "let linkFormat=substitute(linkFormat,"\"","","g")
  "Insere a variável no lugar em q o cursors etá
  exec "norm a" . l:linkFormat . " "
endfunction
command! -nargs=* PasteLink call PasteWikiLink(<q-args>)

function! GenerateLinksCurrent()
  let l:path=expand('%:p:h')
  let l:path=substitute(path,expand(g:vimwiki_list[0].path),"","")
  let l:path=substitute(path,"/","","")
  "https://stackoverflow.com/questions/3098521/how-to-detect-if-a-specific-file-exists-in-vimscript
  exec "VimwikiGenerateLinks " . path . "/*.md"
endfunction
command! GenerateLinks call GenerateLinksCurrent()

function! TermNNN(path)
  " Pasta em q a nota está
  let l:folder=fnamemodify( a:path, ':h' )    
  exec "normal :term nnn " . l:folder . "\<cr>" 
endfunction
command! -nargs=* OpenNNN call TermNNN(<q-args>)

function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [line_start, column_start] = getpos("'<")[1:2]
  let [line_end, column_end] = getpos("'>")[1:2]
  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif
  let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][column_start - 1:]
  return join(lines, "\n")
endfunction

" ------------------------- FZF Plugin ---------------------------------------
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-o': 'Open',
      \ 'ctrl-f': 'OpenNNN',
      \ 'ctrl-y': 'PasteLink', 
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Ctrl f para procurar por aquivos
map <silent><leader>j :Files<CR>
map <silent><leader>b :Buffers<CR>
nnoremap <silent><leader>g :Rg<CR>
nnoremap <silent><leader>G :RG<CR>
nnoremap <silent><leader>H :History<CR>
"nnoremap <leader>t :Tags<CR>
"nnoremap <leader>m :Marks<CR>


let g:fzf_tags_command = 'ctags -R'
" Border color
" Popups não suportados por vim 8.1
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': '', 'border': 'sharp' } }
"let g:fzf_layout = { 'down': '~40%' }


"let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline --preview-window=wrap'
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline' 
let $FZF_DEFAULT_COMMAND="rg --files --hidden"


" Customize fzf colors to match your color scheme
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
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
      \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': '$FZF_DEFAULT_OPTS'}), <bang>0)


" Get text in files with Rg (ripgrep)
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview({'options': '$FZF_DEFAULT_OPTS'}), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command, '--preview-window=wrap']}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" ---------------------- Corfigurações ----------------------------------------
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
let g:onedark_hide_endofbuffer = 1 " Desabilitar os ~~ no fianal do arquivo, quando n tem mais linhas
let g:onedark_terminal_italics = 1
colorscheme onedark
let g:onedark_termcolors=256
highlight Comment cterm=italic

hi VimwikiHeader1 guifg=#61AFEF
hi VimwikiHeader2 guifg=#61AFEF
hi VimwikiHeader3 guifg=#61AFEF
hi VimwikiHeader4 guifg=#61AFEF
hi VimwikiHeader5 guifg=#61AFEF
hi VimwikiHeader6 guifg=#61AFEF


"-------------------- vim-go ----------------------------------------------------
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_auto_sameids = 0
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_fmt_experimental = 1
let g:go_metalinter_autosave=0
let g:go_metalinter_autosave_enabled=['golint', 'govet']
let g:go_def_mapping_enabled = 0 " Desabilitar [gd], o coc-nvim já faz isso

"------------------ polyglot -----------------------------------------
let g:vim_markdown_no_default_key_mappings = 1 " Desabilitar mapas como 'ge' para entrar no link

"================== coc-nvim -----------------------------------------
" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set wildmode=longest:full,full

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>xf <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> ,a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> ,e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> ,c  :<C-u>CocList commands<cr>
" Find symbol of current d,.
nnoremap <silent><nowait> ,o  :<C-u>CocList outline<cr>
" Search workspace symbols,
nnoremap <silent><nowait> ,s  :<C-u>CocList -I symbols<cr>
" Do default action for ne,.
nnoremap <silent><nowait> ,j  :<C-u>CocNext<CR>
" Do default action for pr,item.
nnoremap <silent><nowait> ,k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> ,p  :<C-u>CocListResume<CR>
" Explorer
nnoremap <silent><nowait> <leader>F  :<C-u>CocCommand explorer<CR>

" --------------------- Airline --------------------------
let g:airline_section_a = "Nvim"
