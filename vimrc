execute pathogen#infect()
let mapleader = ","
imap <C-f> <ESC>
vmap <C-f> <ESC>
nmap <C-f> <ESC>
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
map ; :
noremap <C-;> ;
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

cmap w!! w !sudo dd of=%<cr>
autocmd! bufwritepost .vimrc source ~/.vimrc
"autocmd! vimenter * NERDTree

let Tlist_Use_Right_Window = 1
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let Tlist_Show_One_File = 1
map <silent> <leader>nrt :NERDTreeToggle<cr> 
map <silent> <leader>tlt :TlistToggle<cr> 
map <silent> <leader>boc :bo copen<cr>


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

nmap <leader>vg ;vimgrep //gj **/*.lua
nmap <silent> <leader>fd :call Search_Word("")<CR>:bo copen<CR>
function! Search_Word(dir)
	let w =	expand("<cword>")
	let r =	substitute(w, '^ \(.\{-}\) $', '\1', '')
"	execute "echo 'a".r."b'"
	execute "vimgrep /".r."/gj ".a:dir."**/*.lua **/*.c **/*.cpp **/*.h **/*.java **/*.sh"
endfunction


" helper function to toggle hex mode
function! ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries 
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction
" ex command for toggling hex mode - define mapping if desired
command! -bar Hex call ToggleHex()

if filereadable("local.vim")
    source local.vim
endif

let g:EclimLogLevel = 'trace'
let g:EclimCompletionMethod = 'omnifunc'



"autocmd Filetype java setlocal omnifunc=javacomplete#Complete
"setlocal omnifunc=javacomplete#Complete
"map <leader>b :call javacomplete#GoToDefinition()<CR>
