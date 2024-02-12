vim9script

# Vim filetype plugin file
# Language: Odin
# Maintainer: Maxim Kim <habamax@gmail.com>
# Website: https://github.com/habamax/vim-odin
# Last Change: 2024-01-15

if exists("b:did_ftplugin")
    finish
endif
b:did_ftplugin = 1

b:undo_ftplugin = 'setlocal commentstring<'
      \ .. '| setlocal comments<'
      \ .. '| setlocal suffixesadd<'
      \ .. '| exe "nunmap <buffer> ]]"'
      \ .. '| exe "xunmap <buffer> ]]"'
      \ .. '| exe "nunmap <buffer> [["'
      \ .. '| exe "xunmap <buffer> [["'

setlocal suffixesadd=.odin
setlocal commentstring=//%s
setlocal comments=s1:/*,mb:*,ex:*/,://

def SearchProc(count: number, direction: string = '')
    var cnt = count
    while cnt != 0 && search('\v<\w*>(\s*::\s*proc)@=', $'{direction}W') > 0
        cnt -= 1
    endwhile
enddef

nnoremap <buffer> ]] <scriptcmd>SearchProc(v:count1)<CR>
xnoremap <buffer> ]] <scriptcmd>SearchProc(v:count1)<CR>
nnoremap <buffer> [[ <scriptcmd>SearchProc(v:count1, 'b')<CR>
xnoremap <buffer> [[ <scriptcmd>SearchProc(v:count1, 'b')<CR>
