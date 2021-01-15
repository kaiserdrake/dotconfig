" Set the line number style
function! global#settings#set_line_number(...)
    if (a:1 ==? 'relative')
        setlocal number
        setlocal relativenumber
    elseif (a:1 ==? 'on')
        setlocal number
        setlocal norelativenumber
    elseif (a:1 ==? 'off')
        setlocal nonumber
        setlocal norelativenumber
    endif
    echom a:1
endfunction

" Return meta information on environment
function! global#settings#get_env_context(...)
    if empty($META_IMAGEREF)
        return hostname()
    endif
    return $META_IMAGEREF
endfunction
