" vim: set foldmethod=marker foldlevel=0 nomodeline:
" ============================================================================
" initial section {{{
" ============================================================================
augroup vimrc
  autocmd!
augroup END

let g:did_install_default_menus = 1
let g:did_install_syntax_menu   = 1
let g:loaded_2html_plugin       = 1
let g:loaded_getscript          = 1
let g:loaded_getscriptPlugin    = 1
let g:loaded_gzip               = 1
let g:loaded_matchparen         = 1
let g:loaded_netrw              = 1
let g:loaded_netrwFileHandlers  = 1
let g:loaded_netrwPlugin        = 1
let g:loaded_netrwSettings      = 1
let g:loaded_rrhelper           = 1
let g:loaded_tar                = 1
let g:loaded_tarPlugin          = 1
let g:loaded_vimball            = 1
let g:loaded_vimballPlugin      = 1
let g:loaded_zip                = 1
let g:loaded_zipPlugin          = 1
let g:skip_loading_mswin        = 1

let s:darwin = has('mac')
let s:windows = has('win32') || has('win64')
let mapleader = ' '
let maplocalleader = ' '

" }}}
" ============================================================================
" vim-plug
" ============================================================================
silent! if plug#begin('~/.vim/plugged')
let g:polyglot_disabled = ['sensible', 'autoindent']
Plug 'sheerun/vim-polyglot'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
let g:material_terminal_italics = 1
let g:material_theme_style = 'palenight'
Plug 'itchyny/vim-parenmatch'
Plug 'Sirver/ultisnips'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'vim-jp/vimdoc-ja'
set helplang=ja
Plug 'mattn/vim-molder'
Plug 'mattn/vim-molder-operations'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'captbaritone/better-indent-support-for-php-with-html'
Plug 'bfrg/vim-fzy'
Plug 'junegunn/vim-easy-align'
call plug#end()
endif

if !empty('~/.vim/autoload/plug.vim')
  nnoremap <leader>i :w <bar> so $MYVIMRC <bar> PlugInstall<cr>
  nnoremap <leader>c :w <bar> so $MYVIMRC <bar> PlugClean<cr>

  function! s:is_plugged(name) abort
    if exists('g:plugs') && has_key(g:plugs, a:name) && isdirectory(g:plugs[a:name].dir)
      return 1
    else
      return 0
    endif
  endfunction
endif

" ============================================================================
" basic settings
" ============================================================================
set autoindent
set smartindent
set lazyredraw
set laststatus=2
set backspace=indent,eol,start
set ttimeoutlen=0
set shortmess=aIT
" set hlsearch " CTRL-L / CTRL-R W
set incsearch
set hidden
set noswapfile
set nowrap
set ignorecase
set smartcase
set wildmenu
set wildmode=full
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set shiftround
set scrolloff=5
set encoding=utf-8
set list
set listchars=tab:\|\ ,
set virtualedit=block
set nojoinspaces
set diffopt=filler,horizontal
set autoread
" set clipboard=unnamed
set foldlevelstart=99
set grepformat=%f:%l:%c:%m,%f:%l:%m
set completeopt=menuone,preview
set nocursorline
set nrformats=hex,unsigned
silent! set cryptmethod=blowfish2

augroup vimrc_formatoptions
  autocmd!
  autocmd BufEnter * set formatoptions-=r
  autocmd BufEnter * set formatoptions-=o
  autocmd BufEnter * set formatoptions+=1
  autocmd BufEnter * set formatoptions+=M
  if has('patch-7.3.541')
    set formatoptions+=j
  endif
augroup END

if has('patch-7.4.338')
  let &showbreak = '↳ '
  set breakindent
  set breakindentopt=sbr
endif

set modelines=2
set synmaxcol=1000

" ctags
set tags=./tags;/

" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,.

" Semi-persistent undo
if has('persistent_undo')
  set undodir=/tmp,.
  set undofile
endif

" set complete=.,w,b,u,t
set complete-=i

" mouse
silent! set ttymouse=xterm2
" set mouse=a

" Keep the cursor on the same column
set nostartofline

" FOOBAR=~/<CTRL-><CTRL-F>
set isfname-==

if exists('&fixeol')
  set nofixeol
endif

" avoid warning message
set maxmempattern=5000

" color
if has('termguicolors')
  set termguicolors

  if exists('$TMUX')
    let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
    let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
  endif

  " italic support
  let &t_ZH="\e[3m"
  let &t_ZR="\e[23m"
endif

augroup highlight
  autocmd!
  autocmd ColorScheme * call s:highlight_additional()
augroup END

function! s:highlight_additional() abort
  highlight Normal ctermbg=NONE guibg=NONE
  highlight NonText ctermbg=NONE guibg=NONE
  highlight LineNr ctermbg=NONE guibg=NONE
  highlight SignColumn ctermbg=NONE guibg=NONE
  highlight link cssBraceError none
  if g:colors_name == 'material' && g:material_theme_style == 'palenight'
  endif
endfunction

silent! colorscheme material

" ============================================================================
" mappings
" ============================================================================
" ----------------------------------------------------------------------------
" basic mappings
" ----------------------------------------------------------------------------

" vimrc
nnoremap <leader>v :vs $MYVIMRC<cr>
nnoremap <leader>. :so $MYVIMRC<cr>

" save
nnoremap <leader>w :up<cr>

" quit
nnoremap <leader>q :wq<cr>

" Y behave like other capitals
nnoremap Y y$

" qq to record, Q to replay
nnoremap Q @q

" go to parent directory.
nnoremap <leader>- :e %:h<cr>

" ----------------------------------------------------------------------------
" moving lines {{{
" ----------------------------------------------------------------------------
nnoremap <silent> <c-k> :move-2<cr>
nnoremap <silent> <c-j> :move+<cr>
" nnoremap <silent> <c-h> <<
" nnoremap <silent> <c-l> >>
xnoremap <silent> <c-k> :move-2<cr>gv
xnoremap <silent> <c-j> :move'>+<cr>gv
" xnoremap <silent> <c-h> <gv
" xnoremap <silent> <c-l> >gv
" xnoremap < <gv
" xnoremap > >gv

" }}}
" ----------------------------------------------------------------------------
" readline-style key bindings in command-line (excerpt from rsi.vim) {{{
" ----------------------------------------------------------------------------
cnoremap        <c-a> <home>
cnoremap        <c-b> <left>
cnoremap <expr> <c-d> getcmdpos()>strlen(getcmdline())?"\<lt>C-D>":"\<lt>del>"
cnoremap <expr> <c-f> getcmdpos()>strlen(getcmdline())?&cedit:"\<lt>right>"
cnoremap        <m-b> <s-left>
cnoremap        <m-f> <s-right>
silent! exe "set <s-left>=\<esc>b"
silent! exe "set <s-right>=\<esc>f"

" }}}
" ============================================================================
" functions / commands
" ============================================================================
" ----------------------------------------------------------------------------
" filetype settings {{{
" ----------------------------------------------------------------------------
augroup vimrc_set_ft
  autocmd!
  autocmd BufEnter * call s:set_ft_none()
augroup END

function! s:set_ft_none() abort
  if @% == ""
    setlocal filetype=none
  endif
endfunction

" }}}
" ----------------------------------------------------------------------------
" check syntax info {{{
" ----------------------------------------------------------------------------
function! s:get_syn_id(transparent) abort
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid) abort
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info() abort
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()

" }}}
" ----------------------------------------------------------------------------
" window maximize {{{
" ----------------------------------------------------------------------------
let g:toggle_window_size = 0
function! ToggleWindowSize()
  if g:toggle_window_size == 1
    exec "normal \<C-w>="
    let g:toggle_window_size = 0
  else
    :resize
    :vertical resize
    let g:toggle_window_size = 1
  endif
endfunction
nnoremap <c-w>z :call ToggleWindowSize()<CR>

" }}}
" ============================================================================
" plugin settings
" ============================================================================
" ----------------------------------------------------------------------------
" vim-molder {{{
" ----------------------------------------------------------------------------
if s:is_plugged('vim-molder')
  let g:molder_show_hidden = 1
  augroup vimrc_pi_molder
    autocmd FileType molder nmap <buffer> h <plug>(molder-up)
    autocmd FileType molder nmap <buffer> l <plug>(molder-open)
    autocmd FileType molder nmap <buffer> . <plug>(molder-toggle-hidden)
    autocmd FileType molder nnoremap <buffer><nowait> g gg
    autocmd FileType molder nnoremap <buffer> / /\c
  augroup END
endif

if s:is_plugged('vim-molder-operations')
  augroup vimrc_pi_molder_operations
    autocmd!
    autocmd FileType molder nmap <buffer><nowait> m <plug>(molder-operations-newdir)
    autocmd FileType molder nmap <buffer> D <plug>(molder-operations-delete)
    autocmd FileType molder nmap <buffer> r <plug>(molder-operations-rename)
    autocmd FileType molder nnoremap <buffer> n :e %:p:h/
  augroup END
endif

" }}}
" ----------------------------------------------------------------------------
" vim-textobj-entire {{{
" ----------------------------------------------------------------------------
if s:is_plugged('vim-textobj-entire')
  let g:textobj_entire_no_default_key_mappings = 1
  omap ie <plug>(textobj-entire-a)
  xmap ie <plug>(textobj-entire-a)
endif

" }}}
" ----------------------------------------------------------------------------
" ultisnips {{{
" ----------------------------------------------------------------------------
if s:is_plugged('ultisnips')
  let g:UltiSnipsEditSplit = 'vertical'
  let g:UltiSnipsSnippetDirectories = ['~/.vim/ultisnips']
  let g:UltiSnipsSnippetAuthor = 'gairrr'
  let g:UltiSnipsFocusModule = ''

  function! SetFocusModule(name)
    let g:UltiSnipsFocusModule = a:name
  endfunction
  command! -nargs=1 SetFocusModule call SetFocusModule(<f-args>)

  function! GetFocusModule()
    if g:UltiSnipsFocusModule != ""
      return g:UltiSnipsFocusModule . "_"
    else
      return ""
    endif
  endfunction
  command! -nargs=0 GetFocusModule call GetFocusModule()

  nnoremap <silent> <leader>u :<c-u>UltiSnipsEdit<cr>
  nnoremap <leader>s :<c-u>SetFocusModule<space>
  augroup vimrc_pi_ultisnips
    autocmd!
    autocmd FileType snippets set expandtab
    autocmd FileType scss nnoremap <buffer><silent> <leader>u :<c-u>UltiSnipsEdit css<cr>
    autocmd FileType scss nnoremap <buffer><silent> <leader>U :<c-u>UltiSnipsEdit scss<cr>
    autocmd FileType php nnoremap <buffer><silent> <leader>u :<c-u>UltiSnipsEdit html<cr>
    autocmd FileType php nnoremap <buffer><silent> <leader>U :<c-u>UltiSnipsEdit php<cr>
  augroup END
endif

" }}}
" ----------------------------------------------------------------------------
" vim-fzy
" ----------------------------------------------------------------------------
if s:is_plugged('vim-fzy')
  nnoremap <c-p> :FzyFind<cr>
endif

" ----------------------------------------------------------------------------
" vim-easy-align {{{
" ----------------------------------------------------------------------------
if s:is_plugged('vim-easy-align')
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
endif

" }}}
" ============================================================================
" AUTOCMD
" ============================================================================

augroup auto_remove_trailing_whitespace
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
augroup END

augroup vimrc_ft_html
  autocmd!
  autocmd FileType html setlocal iskeyword+=-
augroup END

augroup vimrc_ft_css
  autocmd!
  autocmd FileType css,scss setlocal iskeyword+=-
  autocmd FileType css,scss nnoremap <buffer> p p=']
  autocmd FileType css,scss xnoremap <buffer> p p=']
  autocmd FileType css,scss nnoremap <buffer> P P=']
  autocmd FileType css,scss xnoremap <buffer> P P=']
augroup END

augroup vimrc_ft_php
  autocmd!
  autocmd FileType php setlocal iskeyword+=-
augroup END

" ============================================================================
" LOCAL VIMRC
" ============================================================================

" ============================================================================

