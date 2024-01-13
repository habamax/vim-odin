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

    if prev == 0
        return 0
    endif

    var prevline = getline(prev)
    var line = getline(lnum)

    var indent = indent(prev)

    if prevline =~ '[({]\s*$'
        indent += &sw
    endif

    if line =~ '^\s*[)}]'
        indent -= &sw
    endif

    return indent
enddef
