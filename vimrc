" Modeline and Notes
"   This is my personal .vimrc, I don't recommend you copy it, just
"   use the "   pieces you want(and understand!).  When you copy a
"   .vimrc in its entirety, weird and unexpected things can happen.
"
"   If you find an obvious mistake hit me up at:
"   http://robertmelton.com (many forms of communication)

" has("gui_win32") || has("win32") || has("win32unix") || has("win64")
" has("gui_mac") || has("gui_macvim") || has("mac") || has("macunix")
" has("gui_gnome") || has("gui_gtk") || has("gui_gtk2")

" Startup
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    " let s:running_windows = has("win16") || has("win32") || has("win64")
    let s:colorful_term = (&term =~ "xterm") || (&term =~ "screen")
    let g:erlangHighlightBif = 1
    let g:erlangHighLightOperators = 1

" Functions those should before basic
    func! GetRunningOS()
        if has("win32")
            return "windows"
        elseif has("unix")
            if system('uname')=~'Darwin'
                return "mac"
            else
                return "linux"
            endif
        endif
    endfu
    let g:os=GetRunningOS()

" Basics
    set nocompatible " explicitly get out of vi-compatible mode
    set noexrc " don't use local version of .(g)vimrc, .exrc
    set background=dark " we plan to use a dark background
    set fencs=ucs-bom,utf-8,chinese,taiwan,japan,korean,latin1
    set fenc=utf-8
    if g:os=="windows" || g:os=="mac"
        set fenc=utf-8
        set tenc=utf-8
        set enc=utf-8
    elseif g:os=="linux"
        set fenc=utf-8
        set tenc=utf-8
        let s:enc=""
        if exists("$LANG") && $LANG != "C"
            let s:enc = substitute($LANG, '\w\{2\}_\w\{2\}\.', "", "")
        endif
        if s:enc != ""
            let &enc=s:enc
        else
            set enc=utf-8
        endif
    endif
    language messages en_US.UTF-8 " fix Unrecognizable Code in console output
    set langmenu=en_US.UTF-8 " set language of menu
    source $VIMRUNTIME/delmenu.vim " prevent menu from becoming Unrecognizable Code
    source $VIMRUNTIME/menu.vim " prevent menu from becoming Unrecognizable Code
    set cpoptions=aABceFsmq
    "             |||||||||
    "             ||||||||+-- When joining lines, leave the cursor between joined lines
    "             |||||||+-- When a new match is created (showmatch) pause for .5
    "             ||||||+-- Set buffer options when entering the buffer
    "             |||||+-- :write command updates current file name automatically add <CR> to the last line when using :@r
    "             |||+-- Searching continues at the end of the match at the cursor position
    "             ||+-- A backslash has no special meaning in mappings
    "             |+-- :write updates alternative file name
    "             +-- :read updates alternative file name
    syntax on " syntax highlighting on
    let g:skip_loading_mswin=1 " Just in case :)

" Newish
    set history=9999 " big old history
    set timeoutlen=300 " super low delay (works for me)
    set formatoptions+=n " Recognize numbered lists
    set formatlistpat=^\\s*\\(\\d\\\|[-*]\\)\\+[\\]:.)}\\t\ ]\\s* "and bullets, too
    set viminfo+=! " Store upper-case registers in viminfo
    set nomore " Short nomore

" General
    filetype plugin indent on " load filetype plugins/indent settings
    set autochdir " always switch to the current file directory
    set backspace=indent,eol,start " make backspace a more flexible
    set backup " make backup files
    set clipboard+=unnamed " share windows clipboard
    set colorcolumn=81
    if g:os == "windows"
        let folderPath=$HOME . '/vimfiles/backup'
        echo(system('if not exist "' . folderPath . '" md "' . folderPath . '"'))
        let &backupdir=folderPath " where to put backup files
        let folderPath=$HOME . '/vimfiles/temp'
        echo(system('if not exist "' . folderPath . '" md "' . folderPath . '"'))
        let &directory=folderPath " directory to place swap files in
        let folderPath=$HOME . '/vimfiles/view'
        let &viewdir=folderPath " directory to mkview
    else
        let folderPath=$HOME . '/.vim/backup'
        echo(system('if [ ! -d "' . folderPath . '" ]; then mkdir "' . folderPath . '"; fi'))
        let &backupdir=folderPath " where to put backup files
        let folderPath=$HOME . '/.vim/temp'
        echo(system('if [ ! -d "' . folderPath . '" ]; then mkdir "' . folderPath . '"; fi'))
        let &directory=folderPath " directory to place swap files in
        let folderPath=$HOME . '/.vim/view'
        let &viewdir=folderPath " directory to mkview
    endif
    set fileformats=unix,dos,mac " support all three, in this order
    set hidden " you can change buffers without saving
    " (XXX: #VIM/tpope warns the line below could break things)
    set iskeyword+=_,$,@,%,# " none of these are word dividers
    set mouse=a " use mouse everywhere
    set noerrorbells " don't make noise
    set whichwrap=b,s,h,l,<,>,~,[,] " everything wraps
    "             | | | | | | | | |
    "             | | | | | | | | +-- "]" Insert and Replace
    "             | | | | | | | +-- "[" Insert and Replace
    "             | | | | | | +-- "~" Normal
    "             | | | | | +-- <Right> Normal and Visual
    "             | | | | +-- <Left> Normal and Visual
    "             | | | +-- "l" Normal and Visual (not recommended)
    "             | | +-- "h" Normal and Visual (not recommended)
    "             | +-- <Space> Normal and Visual
    "             +-- <BS> Normal and Visual
    set wildmenu " turn on command line completion wild style
    set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png " ignore these list file extensions
    set wildmode=list:longest " turn on wild mode huge list
    let html_number_lines = 0
    let html_use_css = 0
    let use_xhtml = 0
    let g:FuzzyFinderOptions = { 'Base':{}, 'Buffer':{}, 'File':{}, 'Dir':{}, 'MruFile':{}, 'MruCmd':{}, 'Bookmark':{}, 'Tag':{}, 'TaggedFile':{}}

" Vim UI
    set incsearch " BUT do highlight as you type you search phrase
    set laststatus=2 " always show the status line
    set lazyredraw " do not redraw while running macros
    set linespace=0 " don't insert any extra pixel lines betweens rows
    set list " we do what to show tabs, to ensure we get them out of my files
    set listchars=tab:>-,trail:- " show tabs and trailing
    set matchtime=5 " how many tenths of a second to blink matching brackets for
    set hlsearch " do not highlight searched for phrases
    set nostartofline " leave my cursor where it was
    set novisualbell " don't blink
    set number " turn on line numbers
    set numberwidth=5 " We are good up to 99999 lines
    set report=0 " tell us when anything is changed via :...
    set ruler " Always show current positions along the bottom
    set scrolloff=10 " Keep 10 lines (top/bottom) for scope
    set shortmess=aOstT " shortens messages to avoid 'press a key' prompt
    set showcmd " show the command being typed
    set showmatch " show matching brackets
    set sidescrolloff=10 " Keep 5 lines at the size
    set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
    "              | | | | |  |   |      |  |     |    |
    "              | | | | |  |   |      |  |     |    + current column
    "              | | | | |  |   |      |  |     +-- current line
    "              | | | | |  |   |      |  +-- current % into file
    "              | | | | |  |   |      +-- current syntax in square brackets
    "              | | | | |  |   +-- current fileformat
    "              | | | | |  +-- number of lines
    "              | | | | +-- preview flag in square brackets
    "              | | | +-- help flag in square brackets
    "              | | +-- readonly flag in square brackets
    "              | +-- rodified flag in square brackets
    "              +-- full path to file in the buffer

" Text Formatting/Layout
    set completeopt=menuone " don't use a pop up menu for completions
    set expandtab " no real tabs please!
    set formatoptions=rq " Automatically insert comment leader on return, and let gq format comments
    set ignorecase " case insensitive by default
    set infercase " case inferred by default
    set wrap " wrap line
    set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
    set smartcase " if there are caps, go case-sensitive
    set shiftwidth=4 " auto-indent amount when using cindent, >>, << and stuff like that
    set softtabstop=4 " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
    set tabstop=4 " real tabs should be 8, and they will show with set list on

" Folding
    set foldenable " Turn on folding
    set foldmethod=indent " Fold on the indent (damn you python)
    set foldlevel=100 " Don't autofold anything (but I can still fold manually)
    set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds
    function SimpleFoldText() " {
        return getline(v:foldstart).' '
    endfunction " }
    set foldtext=SimpleFoldText() " Custom fold text function (cleaner than default)

" Plugin Settings
    let b:match_ignorecase = 1 " case is stupid
    let perl_extended_vars=1 " highlight advanced perl vars inside strings
    let tlist_aspjscript_settings = 'asp;f:function;c:class'
    let tlist_aspvbs_settings = 'asp;f:function;s:sub'
    let tlist_php_settings = 'php;c:class;d:constant;f:function'
    let tlist_vb_settings = 'asp;f:function;c:class'

" Mappings
    " hit f11 to paste
    " set pastetoggle=<f11>
    " space / shift-space scroll in normal mode
    " noremap <S-space> <C-b>
    " noremap <space> <C-f>
    " fuzzymaps
    " nmap <leader>f :FufFileWithCurrentBufferDir<CR>
    " nmap <leader>ff :FufFile<CR>
    " nmap <leader>b :FufBuffer<CR>
    " nmap <leader>t :FufBufferTag<CR>
    " nmap <tab> :FufBufferTag<CR>
    " make arrow keys useful
    " map <left> <ESC>:NERDTree<RETURN>
    " map <right> <ESC>:TagbarToggle<RETURN>
    map <up> <ESC>:bp<RETURN>
    map <down> <ESC>:bn<RETURN>
    map <C-H> :wincmd h<CR>
    map <C-J> :wincmd j<CR>
    map <C-K> :wincmd k<CR>
    map <C-L> :wincmd l<CR>

" Autocommands
    " ruby standard 2 spaces, always
    au BufRead,BufNewFile *.rb,*.rhtml set shiftwidth=2
    au BufRead,BufNewFile *.rb,*.rhtml set softtabstop=2
    " Override types
    au BufNewFile,BufRead *.ahk set filetype=autohotkey
    au BufNewFile,BufRead *.bat set filetype=batch
    au BufNewFile,BufRead *.ps1 set filetype=ps1
    au BufNewFile,BufRead *.md set filetype=markdown
    au BufNewFile,BufRead *.dtl set filetype=htmldjango
    au BufNewFile,BufRead *.json,jquery.*.js set filetype=javascript syntax=jquery
    au BufNewFile,BufRead *.h,*.m,*.mm set filetype=objc
    au BufEnter,VimEnter,FileType *.ahk,*.bat set cindent cinoptions=+0
    au BufEnter,VimEnter,FileType *.autohotkey,*.batch set cindent cinoptions=+0
    " Remember everything (position, folds, etc)
    au BufWinLeave ?* mkview 1
    au BufWinEnter ?* silent loadview 1
    " highlight the columns bigger than 80
    " ======================================
    " highlight FormatWarning ctermbg=red ctermfg=white guibg=#592929 guifg=white
    highlight FormatWarning ctermbg=red guibg=#592929
    " /(\()\@!.\)\+\S\*)/  -->  match like: (NSString*)
    au BufEnter,VimEnter * match FormatWarning /\(\%81v.\+\|\( \|\t\)\+\n\)/

" GUI Settings
if has("gui_running")
    " Basics
    colorscheme molokai
    " colorscheme slate
    set guioptions=ce
    "              ||
    "              |+-- use simple dialogs rather than pop-ups
    "              +-- use GUI tabs, not console style tabs
    set mousehide " hide the mouse cursor when typing
    if has("gui_win32") || has("win32") || has("win32unix") || has("win64")
        set guifont=Consolas:h10
        set gfw=Consolas:h10
    elseif has("gui_gnome") || has("gui_gtk") || has("gui_gtk2")
        set guifont=Consolas\ 10.5
        set gfw=CourierNew\ 10.5
    elseif has("gui_mac") || has("gui_macvim") || has("mac") || has("macunix")
        set guifont=Menlo:h11
        set gfw=Menlo:h11
    endif
    func! SwitchGUIDisplay() " Cusfunc, show a compact gui window
        if !exists("g:gdstate")
            let g:gdstate = 0
        else
            let g:gdstate = 1 - g:gdstate
        endif
        if (g:gdstate)
            set guioptions+=m
            set guioptions+=T
            set guioptions+=L
            set guioptions+=r
            set showtabline=1
        else
            set guioptions-=m
            set guioptions-=T
            set guioptions-=L
            set guioptions-=r
            set showtabline=0
        endif
    endfu
    nmap <F2> :call SwitchGUIDisplay()<CR>
    au VimEnter * call SwitchGUIDisplay()
    " map <F8> <ESC>:set guifont=Consolas:h8<CR>
    " map <F9> <ESC>:set guifont=Consolas:h10<CR>
    " map <F10> <ESC>:set guifont=Consolas:h12<CR>
    " map <F11> <ESC>:set guifont=Consolas:h16<CR>
    " map <F12> <ESC>:set guifont=Consolas:h20<CR>
endif

" Term Settings
if s:colorful_term
    "256 color --
    let &t_Co=256
    colorscheme molokai
    " colorscheme slate
    " restore screen after quitting
    if has("terminfo")
        let &t_Sf="\ESC[3%p1%dm"
        let &t_Sb="\ESC[4%p1%dm"
    else
        let &t_Sf="\ESC[3%dm"
        let &t_Sb="\ESC[4%dm"
    endif
endif

" Odds n Ends
set ttymouse=xterm2 " makes it work in everything

" plugin: vimtweak.dll - gvim transparency in windows
    " Alpha Window - SetAlpha
    " Maximized Window - EnableMaximize
    " EnableCaption - EnableCaption
    " TopMost Window - EnableTopMost
    func! ToggleDarkroom()
        if !exists("g:slate")
            let g:slate=1
            let s:o_lbr=&lbr
            let s:o_wrap=&wrap
            let s:o_colors = exists("g:colors_name") ? g:colors_name : "default"
        else
            let g:slate = 1 - g:slate
        endif
        if (g:slate)
            let &go=""
            set lbr wrap stal&
            call libcallnr("vimtweak.dll", "SetAlpha", 235)
            " call libcallnr("vimtweak.dll", "EnableCaption", 0)
        else
            let &lbr=s:o_lbr
            let &wrap=s:o_wrap
            set stal&
            call libcallnr("vimtweak.dll", "SetAlpha", 255)
            " call libcallnr("vimtweak.dll", "EnableCaption", 1)
        endif
    endfu
    nmap <F10> :call ToggleDarkroom()<CR>
    if has("gui_win32")
        au VimEnter * call ToggleDarkroom()
    elseif has("gui_mac") || has("gui_macvim")
        set transparency=5 " transparency, just work to MacVim
    endif

" plugin: Colorizer
    if has("gui_running")
        au VimEnter * ColorHighlight " start/update highlighting
    endif
    " ColorClear " clear all highlights
    " ColorToggle " toggle highlights
" 
" plugin: RainbowParens
    au VimEnter * RainbowParenthesesToggle " on/off
    au Syntax * RainbowParenthesesLoadRound " ()
    au Syntax * RainbowParenthesesLoadSquare " []
    au Syntax * RainbowParenthesesLoadBraces " {}
    au Syntax * RainbowParenthesesLoadChevrons " <>

" plugin: MiniBufExplorer
    let g:miniBufExplMapWindowNavVim = 1
    let g:miniBufExplMapWindowNavArrows = 1
    let g:miniBufExplMapCTabSwitchBufs = 0
    let g:miniBufExplModSelTarget = 1

" plugin: taglist
    if has("gui_win32") || has("win32") || has("win32unix") || has("win64")
        let Tlist_Ctags_Cmd = 'ctags'
    elseif has("gui_gnome") || has("gui_gtk") || has("gui_gtk2")
        let Tlist_Ctags_Cmd = '/usr/bin/ctags'
    elseif has("gui_mac") || has("gui_macvim") || has("mac") || has("macunix")
        let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
    endif
    let Tlist_Show_One_File = 0
    let Tlist_Exit_OnlyWindow = 1
    let Tlist_User_Right_Window = 0

" plugin NERDTree
    let NERDTreeIgnore = ['\.beam', '\.pyc', 'ebin']
    " let NERDChristmasTree = 1
    " let NERDTreeMinimalUI = 1
    " let NERDTreeDirArrows = 0

    " these function and command make you can run NERDTree command easily.
        " <Original> --> <Customize>
        " NERDTree --> Ntree
        " NERDTreeFind --> Ntree find
        " NERDTreeClose --> Ntree close
    func! Ntree(...)
        let wholeCmd = "NERDTree"
        if exists("a:1")
            let capitalInitial = substitute(a:1, '\(.*\)', '\u\1', '')
            echo capitalInitial
            let wholeCmd = "NERDTree" . capitalInitial
        endif
        exec wholeCmd
    endfu
    command -nargs=? Ntree call Ntree(<f-args>)

" plugin neocomplcache
    let g:acp_enableAtStartup = 0 " Disable AutoComplPop.
    let g:neocomplcache_enable_at_startup = 1 " Use neocomplcache.
    let g:neocomplcache_enable_ignore_case = 1 " Use caseignore
    let g:neocomplcache_enable_smart_case = 1 " Use smartcase.
    let g:neocomplcache_enable_camel_case_completion = 1 " Use camel case completion.
    let g:neocomplcache_enable_underbar_completion = 1 " Use underbar completion.
    let g:neocomplcache_min_syntax_length = 3 " Set minimum syntax keyword length.
    let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
    " Define directory.
    let g:neocomplcache_dictionary_filetype_lists = { 
                \ 'default' : '',
                \ 'vimshell' : $HOME.'/.vimshell_hist',
                \ 'scheme' : $HOME.'/.gosh_completions'
                \ }
    " Define keyword.
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
    " Plugin key-mappings.
    imap <C-k>     <Plug>(neocomplcache_snippets_expand)
    smap <C-k>     <Plug>(neocomplcache_snippets_expand)
    inoremap <expr><C-g>     neocomplcache#undo_completion()
    inoremap <expr><C-l>     neocomplcache#complete_common_string()

    " SuperTab like snippets behavior.
    "imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplcache#close_popup()
    inoremap <expr><C-e>  neocomplcache#cancel_popup()

    " AutoComplPop like behavior.
    "let g:neocomplcache_enable_auto_select = 1

    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplcache_enable_auto_select = 1
    "let g:neocomplcache_disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
    "inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

    " Enable omni completion.
    autocmd BufRead,BufNewFile,FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd BufRead,BufNewFile,FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd BufRead,BufNewFile,FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd BufRead,BufNewFile,FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd BufRead,BufNewFile,FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplcache_omni_patterns')
        let g:neocomplcache_omni_patterns = {}
    endif
    let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
    "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

" Position and size settings
    if g:os=="windows"
        let g:ml =47 | let g:mc =178 | let g:mx =7   | let g:my =7
        let g:ll =47 | let g:lc =101 | let g:lx =7   | let g:ly =7
        let g:rl =47 | let g:rc =101 | let g:rx =547 | let g:ry =7
        let g:lbl=26 | let g:lbc=113 | let g:lbx=0   | let g:lby=327
        let g:rbl=26 | let g:rbc=113 | let g:rbx=469 | let g:rby=327
        let g:ltl=26 | let g:ltc=113 | let g:ltx=0   | let g:lty=0
        let g:rtl=26 | let g:rtc=113 | let g:rtx=469 | let g:rty=0
    elseif g:os=="linux"
        let g:ml =49 | let g:mc =157 | let g:mx =7   | let g:my =29
        let g:ll =49 | let g:lc =87  | let g:lx =5   | let g:ly =28
        let g:rl =49 | let g:rc =87  | let g:rx =569 | let g:ry =29
        let g:lbl=33 | let g:lbc=110 | let g:lbx=4   | let g:lby=342
        let g:rbl=29 | let g:rbc=101 | let g:rbx=644 | let g:rby=335
        let g:ltl=33 | let g:ltc=110 | let g:ltx=4   | let g:lty=28
        let g:rtl=29 | let g:rtc=101 | let g:rtx=644 | let g:rty=29
    elseif g:os=="mac"
        let g:ml =57 | let g:mc =180 | let g:mx =8   | let g:my =28
        let g:ll =57 | let g:lc =105 | let g:lx =4   | let g:ly =26
        let g:rl =57 | let g:rc =105 | let g:rx =539 | let g:ry =26
        let g:lbl=34 | let g:lbc=118 | let g:lbx=3   | let g:lby=325
        let g:rbl=34 | let g:rbc=118 | let g:rbx=448 | let g:rby=325
        let g:ltl=34 | let g:ltc=118 | let g:ltx=3   | let g:lty=26
        let g:rtl=34 | let g:rtc=118 | let g:rtx=448 | let g:rty=26
    endif

    " let g:themax=9999
    " if g:os=="windows"
    "     let g:ml =g:themax | let g:mc =g:themax | let g:mx =0        | let g:my =0
    "     let g:ll =g:themax | let g:lc =101      | let g:lx =0        | let g:ly =0
    "     let g:rl =g:themax | let g:rc =101      | let g:rx =547      | let g:ry =0
    "     let g:lbl=26       | let g:lbc=113      | let g:lbx=0        | let g:lby=327
    "     let g:rbl=26       | let g:rbc=113      | let g:rbx=469      | let g:rby=327
    "     let g:ltl=26       | let g:ltc=113      | let g:ltx=0        | let g:lty=0
    "     let g:rtl=26       | let g:rtc=113      | let g:rtx=469      | let g:rty=0
    " elseif g:os=="linux"
    "     let g:ml =g:themax | let g:mc =g:themax | let g:mx =0        | let g:my =0
    "     let g:ll =g:themax | let g:lc =100      | let g:lx =0        | let g:ly =0
    "     let g:rl =g:themax | let g:rc =100      | let g:rx =466      | let g:ry =0
    "     let g:lbl=29       | let g:lbc=101      | let g:lbx=0        | let g:lby=355
    "     let g:rbl=29       | let g:rbc=101      | let g:rbx=644      | let g:rby=355
    "     let g:ltl=29       | let g:ltc=101      | let g:ltx=0        | let g:lty=0
    "     let g:rtl=29       | let g:rtc=101      | let g:rtx=644      | let g:rty=0
    " elseif g:os=="mac"
    "     let g:ml =g:themax | let g:mc =g:themax | let g:mx =0        | let g:my =0
    "     let g:ll =g:themax | let g:lc =105      | let g:lx =0        | let g:ly =0
    "     let g:rl =g:themax | let g:rc =105      | let g:rx =g:themax | let g:ry =0
    "     let g:lbl=34       | let g:lbc=118      | let g:lbx=0        | let g:lby=g:themax
    "     let g:rbl=34       | let g:rbc=118      | let g:rbx=g:themax | let g:rby=g:themax
    "     let g:ltl=34       | let g:ltc=118      | let g:ltx=0        | let g:lty=0
    "     let g:rtl=34       | let g:rtc=118      | let g:rtx=g:themax | let g:rty=0
    " endif

    let hostfile=""
    if g:os=="windows"
        let hostfile=$HOME . '/vimfiles/gvimrc-' . substitute(hostname(), "\\..*", "", "")
    else
        let hostfile=$HOME . '/.vim/gvimrc-' . substitute(hostname(), "\\..*", "", "")
    endif
    if filereadable(hostfile)
        exe 'source ' . hostfile
    endif

    func! Size(posi) " here
        if a:posi ==? 'max' || a:posi ==? 'm'
            exec "winpos ".g:mx." ".g:my
            exec "set lines=".g:ml." columns=".g:mc
        elseif a:posi ==? 'left' || a:posi ==? 'l'
            exec "winpos ".g:lx." ".g:ly
            exec "set lines=".g:ll." columns=".g:lc
        elseif a:posi ==? 'right' || a:posi ==? 'r'
            exec "winpos ".g:rx." ".g:ry
            exec "set lines=".g:rl." columns=".g:rc
        elseif a:posi ==? 'leftbottom' || a:posi ==? 'lb'
            exec "winpos ".g:lbx." ".g:lby
            exec "set lines=".g:lbl." columns=".g:lbc
        elseif a:posi ==? 'rightbottom' || a:posi ==? 'rb'
            exec "winpos ".g:rbx." ".g:rby
            exec "set lines=".g:rbl." columns=".g:rbc
        elseif a:posi ==? 'lefttop' || a:posi ==? 'lt'
            exec "winpos ".g:ltx." ".g:lty
            exec "set lines=".g:ltl." columns=".g:ltc
        elseif a:posi ==? 'righttop' || a:posi ==? 'rt'
            exec "winpos ".g:rtx." ".g:rty
            exec "set lines=".g:rtl." columns=".g:rtc
        else
            exec "echo('\"".a:posi."\" is not supported size!')"
        endif
    endfu

    command -nargs=1 Size call Size(<f-args>)

    au VimEnter * Size rb
