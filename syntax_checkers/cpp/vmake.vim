"============================================================================
"File:        vmake.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  Vercas
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"============================================================================

if exists('g:loaded_syntastic_cpp_vmake_checker')
    finish
endif
let g:loaded_syntastic_cpp_vmake_checker = 1

if !exists('g:syntastic_cpp_compiler_options')
    let g:syntastic_cpp_compiler_options = ''
endif

let s:save_cpo = &cpo
set cpo&vim

function! SyntaxCheckers_cpp_vmake_IsAvailable() dict
    call self.log('vmakefile found: ', executable("./vmakefile.lua"))
    return executable("./vmakefile.lua")
endfunction

function! SyntaxCheckers_cpp_vmake_GetLocList() dict
    return syntastic#c#GetLocList('cpp', 'vmake', {
        \ 'errorformat':
        \     '%-G%f:%s:,' .
        \     '%f:%l:%c: %trror: %m,' .
        \     '%f:%l:%c: %tarning: %m,' .
        \     '%f:%l:%c: %m,'.
        \     '%f:%l: %trror: %m,'.
        \     '%f:%l: %tarning: %m,'.
        \     '%f:%l: %m',
        \ 'main_flags': '--lint',
        \ 'header_flags': '',
        \ 'header_names': '\m\.\(h\|hpp\|hh\)$' })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'cpp',
    \ 'name': 'vmake',
    \ 'exec': './vmakefile.lua' })

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set sw=4 sts=4 et fdm=marker:
