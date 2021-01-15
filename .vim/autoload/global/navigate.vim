" Find from project root
function! global#navigate#find_project_file(...)
    execute 'Files' ProjectRootGuess()
endfunction

" Find from project root
function! global#navigate#find_project_file_all(...)
    execute 'AllFiles' ProjectRootGuess()
endfunction

" Open personal devnotes
function! global#navigate#open_devnotes(...)
    if isdirectory(g:devnotes_location)
        :execute 'edit ' . g:devnotes_location . a:1
    else
        echom 'Please configure g:devnotes_location.'
    endif
endfunction
