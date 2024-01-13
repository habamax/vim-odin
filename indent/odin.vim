vim9script

# Vim indent plugin file
# Language: odin
# Maintainer: Maxim Kim <habamax@gmail.com>
# Website: https://github.com/habamax/vim-odin

if exists("b:did_indent")
    finish
endif
b:did_indent = 1

setlocal indentexpr=GetOdinIndent(v:lnum)

def GetOdinIndent(lnum: number): number
    var prev = prevnonblank(lnum - 1)

    var prevline = getline(prev)
    var line = getline(lnum)

    var indent = indent(prev)

    if prevline =~ '[({:]\s*$'
        indent += shiftwidth()
    elseif line =~ '^\s*}'
        var ln_start = searchpair('{', '', '}', 'bn')
        if ln_start != -1
            indent = indent(ln_start)
        endif
    elseif line =~ '^\s*)'
        var ln_start = searchpair('(', '', ')', 'bn')
        if ln_start != -1
            indent = indent(ln_start)
        endif
    elseif (line =~ '^\s*case\(\s\+.\{-}\)\?:\s*$' &&
            prevline !~ '^\s*case\(\s\+.\{-}\)\?:')
        indent -= shiftwidth()
    endif

    return indent
enddef
