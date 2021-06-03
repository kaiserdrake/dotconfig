" -----------------------------------------------------------------------------
" VIM customization
" -----------------------------------------------------------------------------
" Plugin Manager (uses vim-plug) {{{
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Post plug install/update hook
function! PlugPostUpdate(info)
    " info is a dictionary with 3 fields
    " - name:   name of the plugin
    " - status: 'installed', 'updated', or 'unchanged'
    " - force:  set on PlugInstall! or PlugUpdate!
    if a:info.name == 'vim-which-key'
        if a:info.status == 'installed' || a:info.force
        endif
    endif
endfunction
"}}}
" Plugins list {{{
call plug#begin('~/.config/vim/plugged')

" show git line status in gutter
Plug 'airblade/vim-gitgutter'

" find project root
Plug 'dbakker/vim-projectroot'

" incremental search improved
Plug 'haya14busa/is.vim'

" editor configuration per project
Plug 'editorconfig/editorconfig-vim'

" status line makeover
Plug 'itchyny/lightline.vim'

" git branch information
Plug 'itchyny/vim-gitbranch'

" org-mode and dependencies
Plug 'jceb/vim-orgmode'
Plug 'tpope/vim-speeddating'   " Allows quick insertation of date
Plug 'mattn/calendar-vim'      " Allows calender date selection
Plug 'vim-scripts/SyntaxRange' " Allows syntax inside org src block

" Atom one dark colortheme
Plug 'joshdick/onedark.vim'

" focus mode when presenting
Plug 'junegunn/goyo.vim'

" align contents
Plug 'junegunn/vim-easy-align'

" fzf vim integration
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" sneak
Plug 'justinmk/vim-sneak'

" leader key guide
Plug 'liuchengxu/vim-which-key',
    \ {
    \  'do': function('PlugPostUpdate')
    \ }

" tab completion
Plug 'ervandew/supertab'

" tags
Plug 'ludovicchabant/vim-gutentags'

" language extensions for syntax highlighting
Plug 'sheerun/vim-polyglot'

" turn lines into table
Plug 'stormherz/tablify'

" comment/uncomments lines of code
Plug 'tpope/vim-commentary'

" vim session manager
Plug 'tpope/vim-obsession'

" indent line guide
Plug 'yggdroot/indentLine'

call plug#end()
"}}}
" Status line{{{
function! s:statusline_expr()
    let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
    let ro  = "%{&readonly ? '[RO] ' : ''}"
    let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
    let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
    let sep = ' %= '
    let pos = ' %-12(%l : %c%V%) '
    let pct = ' %P'
    return '[%n] %f %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
endfunction

let &statusline = s:statusline_expr()
"}}}
" Basic settings{{{

let mapleader = "\<Space>"
let maplocalleader = ','
let g:vim_key_map =  {}               " globally declare key-map
let g:vim_localkey_map = {}           " globally declare local key-map

" Research any of these by running :help <setting>
set autochdir                     " automatically cd to buffer location
set autoindent                    " autoindent next line w.r.t current line
set autoread                      " read buffer automatically when changed in term
set backspace=indent,eol,start    " backspace delete characters as usual
set backupdir=/tmp//,.            " backup location
set clipboard=unnamedplus         " sync with system clipboard
"set colorcolumn=80                " set visual marker on column 80
set complete+=kspell              " autocomplete with dictionary words
set completeopt=menuone,longest   " popup menu behavior
set conceallevel=0                " show everything in text
set cmdheight=1                   " provide space for error message
"set cryptmethod=blowfish2         " encrypt swap and undo files
set cursorline                    " use line cursor
set directory=/tmp//,.            " location of swap files
set encoding=utf-8                " default file encoding
set expandtab smarttab            " enable smarttab
set formatoptions=tcqron1         " paragraph reformat options
set guicursor=""                  " disable cursor feature (rel. conhost.exe block cursor issue)
set hidden                        " show hidden characters
set hlsearch                      " enable highlight search
set ignorecase                    " ignore case when searching
set incsearch                     " enable incremental search
set laststatus=2                  " set last status
set matchpairs+=<:>               " use % to jump between pairs
set mmp=5000                      " set memory footprint
"set modelines=2                   " enable modeline
set mouse=a                       " enable mouse
set nobackup                      " disable creation of backup files
set nocompatible                  " disable compatibilty with old versions
set noerrorbells visualbell t_vb= " disable bells
set noshiftround                  " disable indent rounding to shift length
set noshowmode                    " do not display the buffer mode anymore
set nospell                       " disable spell check
set nostartofline                 " retain cursor position after switching buffers
set nowrap                        " show lines as they are
set nowritebackup                 " disable write backups
set number relativenumber         " show relative line number
set regexpengine=1                " set regex engine to old engine that works with everything
set ruler                         " always show cursor position
set scrolloff=3                   " number of lines to keep above and below cursor
set shell=/bin/bash               " use bash as default shell
set shiftwidth=4                  " shiftwidth
set showcmd                       " show command history
set showmatch                     " show matching braces
set shortmess+=c                  " dont give ins-completion menu messages
set smartcase                     " auto switch to case-sensitive when query is all upercase
set softtabstop=4                 " allow keeping of tab indents
set spelllang=en_us               " default dictionary language
set splitbelow                    " horizontal split appears below
set splitright                    " vertical split appears on the right
set tabstop=4                     " length of tab
set tags=./tags,tags;             " Find tags from curdir
set textwidth=0                   " use full width of window
set ttimeout                      " disable timeout for key codes
"set ttyfast                       " use fast terminal connection
"set ttymouse=sgr                  " terminal mouse codes
set undodir=/tmp                  " location of undo index
set undofile                      " store undo index on a file
set updatetime=300                " cursor hold time
set virtualedit=block             " enable block edit
set whichwrap=b,s,<,>             " allow backspace, space, and , for cursor movements
set wildmenu                      " enable command-line copletion in enhance mode
set wildmode=full                 " enable wildcards in completion

"}}}
" Basic autocommands{{{

" Auto-resize splits when Vim gets resized.
autocmd VimResized * wincmd =

" Update a buffer's contents on focus if it changed outside of Vim.
au FocusGained,BufEnter * :checktime

" Unset paste on InsertLeave.
autocmd InsertLeave * silent! set nopaste

" Make sure all types of requirements.txt files get syntax highlighting.
autocmd BufNewFile,BufRead requirements*.txt set syntax=python

" Ensure tabs don't get converted to spaces in Makefiles.
autocmd FileType make setlocal noexpandtab

" Only show the cursor line in the active buffer.
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

" Set colorcolumn depending on filetype
autocmd FileType
    \ cpp,c,cxx,h,hpp,python,sh,vim,cmake,make,conf
    \ setlocal cc=80
autocmd FileType
    \ text,markdown
    \ setlocal cc=120

" Set foldmethod=marker to vim files
autocmd FileType vim setlocal foldmethod=marker

" Enable undocumented native markdown folding for vim
let g:markdown_folding = 1
autocmd FileType markdown setlocal foldlevel=1

" Disable line numbers in terminal
if exists('##TerminalOpen')
    au TerminalOpen * setlocal listchars= nonumber norelativenumber
endif
au BufEnter,BufWinEnter,WinEnter term://* startinsert
au BufLeave term://* stopinsert

" Highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

"}}}
" Basic commands{{{

" Add all TODO items to the quickfix list relative to where you opened Vim.
function! s:todo() abort
    let entries = []
    for cmd in ['git grep -niIw -e TODO -e FIXME 2> /dev/null',
        \ 'grep -rniIw -e TODO -e FIXME . 2> /dev/null']
        let lines = split(system(cmd), '\n')
        if v:shell_error != 0 | continue | endif
        for line in lines
            let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
            call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
        endfor
        break
    endfor
    if !empty(entries)
        call setqflist(entries)
        copen
    endif
endfunction

command! Todo call s:todo()

" List files without restrictions
command! -bang -nargs=? -complete=dir AllFiles
    \ call fzf#vim#files(<q-args>, {'source': "rg --files --hidden --follow --no-messages --no-ignore-vcs"}, <bang>0)

" List project directories under PRIMARY_WORKSPACE
command! -bang -nargs=? -complete=dir ProjectsList
    \ call fzf#vim#files(<q-args>, {'source': "find $PRIMARY_WORKSPACE \\( -name .git -o -name .svn -o -name .editorconfig \\) -exec dirname {} \\; -prune | sort -u"}, <bang>0)

" Profile Vim by running this command once to start it and again to stop it.
function! s:profile(bang)
    if a:bang
        profile pause
        noautocmd qall
    else
        profile start /tmp/profile.log
        profile func *
        profile file *
    endif
endfunction

command! -bang Profile call s:profile(<bang>0)

"}}}
" netrw tweaks{{{
let g:netrw_banner = 0 " remove unnecessary information
let g:netrw_winsize = 20 " set new netrw splits 20%
"}}}
" Color theme{{{

" Enable 24-bit true colors if your terminal supports it.
if (has("termguicolors"))
    " https://github.com/vim/vim/issues/993#issuecomment-255651605
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
else
    let g:onedark_termcolors=256
endif

" Enable italics emulation
let g:onedark_terminal_italics=1
" Hide buffer endlines
let g:onedark_hide_endofbuffer=1

" Enable syntax highlighting.
syntax on

" Set the color scheme.
silent! colorscheme onedark

" Set the color scheme to dark.
set background=dark
"}}}
" lightline{{{
let g:lightline = {
    \ 'colorscheme': 'onedark',
    \ 'active': {
        \   'left':  [ [ 'mode', 'paste' ],
        \              [ 'gitbranch', 'filename', 'readonly', 'modified' ] ],
        \   'right': [ [ 'metainfo' ],
        \              [ 'percent' , 'lineinfo' ],
        \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
        \ },
    \ 'component': {
        \   'charvaluehex': '0x%02B'
        \ },
    \ 'component_function': {
        \   'gitbranch'   : 'gitbranch#name',
        \   'metainfo'    : 'global#settings#get_env_context',
        \ },
    \ 'mode_map': {
        \ 'n' : 'N',
        \ 'i' : 'I',
        \ 'R' : 'R',
        \ 'v' : 'V',
        \ 'V' : 'VL',
        \ "\<C-v>": 'VB',
        \ 'c' : 'C',
        \ 's' : 'S',
        \ 'S' : 'SL',
        \ "\<C-s>": 'SB',
        \ 't': 'T',
        \ },
    \ }
"}}}
" vim-projectroot{{{
" override rootmakers to include .editorconfig
let g:rootmarkers = ['.projectroot', '.git', '.svn', '.editorconfig']

" try to follow buffers on their root, should default to $HOME
" due to the existence of .editorconfig
function! s:AutoProjectRootCD()
    try
        if &ft != 'help'
            ProjectRootCD
        endif
    catch
        " Silently ignore invalid buffers
    endtry
endfunction
" change to relative directory upon entering buffer
autocmd BufEnter * call <SID>AutoProjectRootCD()
"}}}
" fzf tweaks{{{

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" Split key bindings when opening files
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit'}

" Enable preview window, set this to empty to disable
let g:fzf_preview_window = 'right:42%'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" Set window layout
let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Allow passing optional flags into the Rg command.
"   Example: :Rg myterm -g '*.md'
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, <bang>0)
"}}}
" vim-which-key{{{
autocmd VimEnter * call which_key#register('<Space>', 'g:vim_key_map')
autocmd VimEnter * call which_key#register(',', 'g:vim_localkey_map')

nnoremap <silent> <Leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <Leader> :<c-u>WhichKeyVisual '<Space>'<CR>

" <C-x> is mapped by default and in speeddating.
" Since our usage of <C-x> has more sequence of key inputs in its mappings
" the original or speeddating mapping are triggered.
" Map it same as <Leader> after all plugins are loaded.
autocmd VimEnter * nnoremap <silent> <C-x> :WhichKey '<Space>'<CR>x

nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual ','<CR>

highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Function
highlight default link WhichKeyDesc      Function

let g:which_key_use_floating_win = 0
let g:which_key_sep = '→'
let g:which_key_hspace = 12
set timeoutlen=400

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
"}}}
" Indent guide{{{
" Disable by default, too much guides in the view makes a clutter.
" Enable only when need to verify indents.
let g:indentLine_enabled = 0

" Set indent guide character
let g:indentLine_char_list = ['│']
"}}}
" Code completion{{{

"}}}
" Org-mode{{{

" Specify action item status list
let g:org_todo_keywords = [['TODO(t)', 'ONGOING(o)', 'DONE(d)', '|', 'WAITING(w)', 'CANCELLED(c)'],
    \ ['*NEW*(n)', 'FIXED(f)', '|', 'TRANSFERRED(f)', 'NONREP(p)'],
    \ ['MEETING(m)']]

"}}}
" WSL settings{{{

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system('cat |' . s:clip, @0) | endif
    augroup END
endif
"}}}
" Sneak settings{{{
" minimalist alternative to easy motion
let g:sneak#label = 1

" case insensitive sneak
let g:sneak#use_ic_scs = 1

" immediately move to the next instance of search, if you move the cursor  is back to default behavior
let g:sneak#s_next = 1

" replace f and t with sneak (one-character sneak)
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" Change the colors
highlight Sneak guifg=black guibg=#E5C07B ctermfg=black ctermbg=yellow
highlight SneakScope guifg=#ABB2BF guibg=#E06C75 ctermfg=gray ctermbg=red

"}}}
" gitgutter settings{{{
let g:gitgutter_enabled = 1

highlight GitGutterAdd    guifg=#98C379 ctermfg=2
highlight GitGutterChange guifg=#61AFEF ctermfg=3
highlight GitGutterDelete guifg=#E06C75 ctermfg=1
"}}}
" Key mappings{{{
" In other to find for available key mappings, use the following commands:
"  :help CTRL-xxx
"  :map
" This configuration requires vim-which-key plugin to be installed. Otherwise
" some key mappings from <Leader> will not work.
" -----------------------------------------------------------------------------
" :global
" -----------------------------------------------------------------------------
" Shortcut for <ESC> during insert mode.
inoremap jk <ESC>
inoremap kj <ESC>

" Seamlessly treat visual lines as actual lines when moving around.
noremap j gj
noremap k gk
" Prevent selecting and pasting from overwriting what you originally copied.
xnoremap p pgvy

" Keep cursor at the bottom of the visual selection after you yank it.
vmap y ygv<Esc>

" Escape back to Normal mode from Terminal mode
tnoremap <C-c><C-c> <C-\><C-n>

" Edit Vim config file in a new tab.
map <Leader>ss :source $MYVIMRC<CR>

" Toggle paste mode
set pastetoggle=<C-p>

" First level leader mappings
let g:vim_key_map['?'] = [':Maps', 'key mapping help']
let g:vim_key_map['/'] = [':Lines', 'search line']
let g:vim_key_map['C'] = [':Commits', 'show commits']
let g:vim_key_map[' '] = [':let @/=""', 'clear highlights']
let g:vim_key_map['T'] = [':term', 'open terminal']
let g:vim_key_map['p'] = [':set paste', 'paste mode <C-p>']
let g:vim_key_map['P'] = [':ProjectsList', 'find project']
let g:vim_key_map['K'] = 'show documentation'

" Let tablify define its own leader mappings
let g:vim_key_map.t = { 'name' : '+tablify commands'}
let g:vim_key_map.t.R = { 'name' : '+realign'}

" -----------------------------------------------------------------------------
" :settings shortcuts
" -----------------------------------------------------------------------------
let g:vim_key_map.s = {
    \ 'name' : '+settings',
    \ 'r' : [':set norelativenumber!', 'relative line numbers'],
    \ 'f' : [':Goyo', 'focus mode'],
    \ 'i' : [':IndentLinesToggle', 'indent guides'],
    \ 'n' : [':set nonumber!', 'line numbers'],
    \ 'N' : {
        \ 'name': 'set-local-line-number',
        \ '1': ['global#settings#set_line_number("relative")', 'relative'],
        \ '2': ['global#settings#set_line_number("on")', 'on'],
        \ '3': ['global#settings#set_line_number("off")', 'off'],
        \ },
    \ }

" -----------------------------------------------------------------------------
" :editing shortcuts
" -----------------------------------------------------------------------------
" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
nnoremap <Leader>er :%s///g<Left><Left>
nnoremap <Leader>erc :%s///gc<Left><Left><Left>

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
xnoremap <Leader>er :s///g<Left><Left>
xnoremap <Leader>erc :s///gc<Left><Left><Left>

" Fill line usually to file comment line with a character
nnoremap <Leader>ef :call global#editing#fill_line('')<Left><Left>
" Shortcut for fill_line('-')
inoremap <C-f> <C-c>:call global#editing#fill_line('-')<CR>o

let g:vim_key_map.e = {
    \ 'name' : '+editing',
    \ 'r' : 'replace search',
    \ 'rc' : 'replace search confirm',
    \ 'f' : 'fill line',
    \ }

" -----------------------------------------------------------------------------
" :explorer
" -----------------------------------------------------------------------------
" Project find file no-ignore
nnoremap <silent> <C-x>F :Files ~<CR>
" Project find file, override C-F (default:scroll down)
nnoremap <silent> <C-x><C-f> :call global#navigate#find_project_file()<CR>
nnoremap <silent> <C-x>f :call global#navigate#find_project_file()<CR>

" Find file no-ignore
nnoremap <silent> <C-x>O :AllFiles ~<CR>
nnoremap <silent> <C-x><C-o> :call global#navigate#find_project_file_all()<CR>
nnoremap <silent> <C-x>o :call global#navigate#find_project_file_all()<CR>

" Open buffer list
nnoremap <silent> <C-x>b :Buffers<CR>
" Kill current buffer
nnoremap <silent> <C-x>k :bd<CR>

" Open personal development notes shortcuts
if !empty($PRIMARY_WORKSPACE)
    let g:devnotes_location = $PRIMARY_WORKSPACE . '/bokuno/notes/'
else
    let g:devnotes_location = '~/'
endif
nnoremap <silent> <C-x>? :call global#navigate#open_devnotes('cheatsheet.md')<CR>

let g:vim_key_map.n = {
    \ 'name': '+dev notes',
        \ '1' : [':call global#navigate#open_devnotes("devnotes.md")','devnotes.md'],
        \ '2' : [':call global#navigate#open_devnotes("commands.md")','commands.md'],
        \ '3' : [':call global#navigate#open_devnotes("docker.abode.md")','docker.abodes.md'],
        \ '?' : [':call global#navigate#open_devnotes("cheatsheet.md")','open cheatsheet <C-x>?'],
    \ }

" Navigation shortcuts
let g:vim_key_map.x = {
    \ 'name' : '+navigation',
    \ 'f' : [':call global#navigate#find_project_file()', 'project find file'],
    \ 'F' : [':Files ~', 'find file'],
    \ 'o' : [':call global#navigate#find_project_file_all()', 'project find file (no-ignore)'],
    \ 'O' : [':AllFiles ~', 'find file (no-ignore)'],
    \ 'e' : [':call feedkeys(":edit " . getcwd() )', 'edit file from getcwd'],
    \ 'E' : [':call feedkeys(":edit ~/")', 'edit file'],
    \ 'b' : [':Buffers', 'find buffer'],
    \ 'k' : [':bd', 'kill buffer'],
    \ 'K' : [':bufdo :bd', 'kill all buffers'],
    \ 'm' : [':Marks', 'show marks'],
    \ 'p' : [':ProjectsList', 'find project'],
    \ 't' : {
        \ 'name': '+tabs',
        \ 'n' : [':tabedit', 'new tab'],
        \ 'c' : [':tabclose', 'close tab'],
        \ '?' : [':tabs', 'tab list'],
        \ 'f' : [':tabfirst', 'first tab'],
        \ 'l' : [':tablast', 'last tab'],
        \ 'g' : [':call feedkeys(":tabm ")', 'goto tab'],
        \ },
    \ }

" -----------------------------------------------------------------------------
" :window mappings
" -----------------------------------------------------------------------------
let g:vim_key_map.w = {
    \ 'name' : '+window',
    \ 's' : [':split', 'split down'],
    \ 'v' : [':vsplit', 'split left'],
    \ 'n' : [':new', 'new window down'],
    \ 'N' : [':new', 'new window left'],
    \ 'q' : [':quit', 'close window'],
    \ 'o' : [':only', 'close others'],
    \ '=' : ['<C-W>=', 'balance windows'],
    \ '?' : [':Windows', 'windows list'],
    \ 'h' : ['<C-W>h', 'window left'],
    \ 'j' : ['<C-W>j', 'window below'],
    \ 'l' : ['<C-W>l', 'window right'],
    \ 'k' : ['<C-W>k', 'window up'],
    \ }

" -----------------------------------------------------------------------------
" :easy-align-vim
" -----------------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <silent> ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <silent> ga <Plug>(EasyAlign)

"}}}
" Auto completion configurations {{{

filetype plugin on
set omnifunc=syntaxcomplete#Complete

"}}}
