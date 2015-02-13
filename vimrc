execute pathogen#infect()

syntax on    
colorscheme torte
hi Pmenu ctermfg=Cyan ctermbg=Blue cterm=None guifg=Cyan guibg=DarkBlue
set nocompatible
set completeopt-=preview
set hidden
set autoread
set number  
set cursorline
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent 
set smartindent
set cindent 
set nobackup    
set hlsearch
set noswapfile
set statusline=%m\ %F\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
filetype plugin indent on  

let mapleader = ","
imap <C-f> <ESC>
vmap <C-f> <ESC>
nmap <C-f> <ESC>
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
cmap w!! w !sudo dd of=%<cr>
nmap <leader>vg ;vimgrep //gj **/*.lua
nmap <silent> <leader>fd :call Search_Word("")<CR>:bo copen<CR>
map ; :
map ' "
map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <C-s> :wa<cr>
map <silent> <leader>ss :source ~/.vimrc<cr>
map <silent> <leader>ee :e ~/.vimrc<cr>
map <silent> <leader>. ,be
map <silent> <leader>rd :edit<cr>
map <silent> <leader>ff :exe "!syscopy.sh" expand('%:p')<cr>
map <silent> <leader>jd :YcmCompleter GoToDeclaration<cr>
map <silent> <leader>rj :wa<cr>:!clear && javac %<cr>:!java -classpath %:p:h %:t:r<cr>
map <silent> <leader>nrt :NERDTreeToggle<cr> 
map <silent> <leader>tlt :TlistToggle<cr> 
map <silent> <leader>boc :bo copen<cr>
map <leader>jd :JavaSearchContext<CR>
map <leader>cd :YcmCompleter GoToDeclaration<CR>
map <leader>ci :YcmCompleter GoToDefinition<CR>

autocmd! vimenter * call My_StartUp()
autocmd! bufwritepost .vimrc source ~/.vimrc

let Tlist_Use_Right_Window = 1
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let Tlist_Show_One_File = 1
let g:EclimCompletionMethod = 'omnifunc'
let g:ConqueTerm_CWInsert = 1
"let g:EclimLogLevel = 'trace'



if filereadable("local.vim")
    source local.vim
endif
