
hi TabLineFill ctermfg=Yellow ctermbg=Yellow
hi TabLine ctermfg=Blue ctermbg=Yellow
hi TabLineSel ctermfg=Red ctermbg=Black

function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= (i+1).'.%{MyTabLabel_dir(' . (i + 1) . ')}  '
    "let s .= ' %{BradLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#'


  return s
endfunction

function! BradLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr   = tabpagewinnr(a:n)
  let bufnam  = bufname(buflist[winnr - 1])
  " This is getting the basename() of bufname above
  let base    = substitute(bufnam, '.*/', '', '')
  let name    = a:n . ' ' . base
  return name
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return bufname(buflist[winnr - 1])
endfunction

function! MyTabLabel_dir(n)
    if has_key(g:tabdirs,a:n)
        return g:tabdirs[a:n]
    else
        let g:tabdirs[a:n]=getcwd()
        return g:tabdirs[a:n]
    endif
endfunction

" Use the above tabe naming scheme
set tabline=%!MyTabLine()
if !exists("g:tabdirs")
    let g:tabdirs={'1':'init', '2':'tab2',}
endif
function! ResetTabDir()
    let nr = tabpagenr()
    let g:tabdirs[nr]=getcwd()
endfunction
autocmd! tabenter * call ResetTabDir()
