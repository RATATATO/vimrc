"
" (c) 2016 RATATATO
" Code licensed under GPL 3.0
"

set ts=2
set sw=2
set expandtab
set incsearch
" Window
set noequalalways
set winwidth=80


" See also
" How do I get vim's :sh command to source my bashrc?
" http://stackoverflow.com/questions/1694599/how-do-i-get-vims-sh-command-to-source-my-bashrc
set shell=bash\ --login
" Switch to direct input engine when I left insert mode.
" au InsertLeave * silent! !ibus engine xkb:us::eng
au InsertLeave * silent! !ibus engine xkb:us::eng
command! Mozc execute "!ibus engine mozc-jp"


" pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on


" clang_complete
let g:clang_auto_select=0
let g:clang_complete_auto=0
let g:clang_complete_macros=1
let g:clang_exec='clang++'
let g:clang_use_library=0
augroup clang_complete
  au BufRead,BufNewFile *.cc let g:clang_user_options='-Iinclude -Itest -std=c++0x'
  au BufRead,BufNewFile *.h let g:clang_user_options='-Iinclude -Itest -std=c++0x'
augroup END


" Execute a.out
command! Aexecute execute "!./a.out"
" Make background
set errorfile=/tmp/AztecC.Err
command! -nargs=? MBackground
  \ | execute ':silent! !make ' . <q-args> . ' > ' . &errorfile . ' 2>&1 &'
  \ | execute ':redraw!'
command! CWindow execute 'cfile | cw'


augroup c_plusplus
  command! Lint execute
    \ "!python /home/suzuki/Dropbox/code/cpplint.py --root=include " .
    \ "--filter=-runtime/references %"
"    \ "!python /home/suzuki/Dropbox/code/cpplint.py " .
  au BufRead,BufNewFile *.cc set tw=79
  au BufRead,BufNewFile *.h set tw=79
"  command! Test11 execute "!clang++ -std=c++11 % -lpthread"
  command! Test11 execute "!clang-3.5 -std=c++11 % -lpthread"
  set smartindent
augroup END


augroup _python
  au Filetype python set tw=79
  au Filetype python set ts=4
  au Filetype python set sw=4
  au Filetype python set omnifunc=pythoncomplete#Complete
augroup END


augroup _verilog
  au Filetype verilog command! -nargs=? Lint execute "!verilator <args> -Wall --language 1364-2001 --lint-only %"
  au Filetype verilog set makeprg=iverilog\ -Wall\ -g2001\ -DSIMULATE_ON_ICARUS\ \%
augroup END


augroup latex
  au BufRead,BufNewFile *.tex set tw=79
  au BufRead,BufNewFile *.tex set formatoptions+=mM
  au BufRead,BufNewFile *.tex command! PLatex execute "!platex % && dvipdf %:r.dvi"
  au BufRead,BufNewFile *.tex command! Uncomment execute "'<,'>s /^%//g"
  au BufRead,BufNewFile *.tex command! Comment execute "'<,'>s /^/%/g"
augroup END


augroup github_markup
  au BufRead,BufNewFile *.md set tw=79
  au BufRead,BufNewFile *.md set formatoptions+=mM
augroup END

augroup javascript
  au Filetype python set tw=79
"  au BufRead,BufNewFile *.js set foldmethod=syntax
"  au BufRead,BufNewFile *.js set foldlevelstart=1
"  au FileType javascript call JavaScriptFold()
augroup END
