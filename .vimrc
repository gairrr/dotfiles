set encoding=utf-8
set nowrap
set hidden
set noswapfile
set incsearch hlsearch
set updatetime=300
set backspace=indent,eol,start
set timeout timeoutlen=3000 ttimeoutlen=0
set expandtab softtabstop=2 shiftwidth=2 shiftround

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

let g:mapleader = ' '

call plug#begin('~/.vim/plugged')
Plug 'Shougo/context_filetype.vim'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-rooter'
" Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/vim-parenmatch'
Plug 'junegunn/fzf.vim' | Plug '/usr/local/opt/fzf'
Plug 'kaicataldo/material.vim'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-repeat'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-user'
Plug 'mattn/vim-molder'
Plug 'mattn/vim-molder-operations'
Plug 'tyru/caw.vim'
Plug 'vim-jp/vimdoc-ja'
call plug#end()

if !empty(glob('~/.vim/autoload/plug.vim'))
  augroup pi_plug
    autocmd!
    autocmd BufRead .vimrc nnoremap <buffer><silent> <leader>i :<c-u>w <bar> so $MYVIMRC <bar> PlugInstall<cr>
    autocmd BufRead .vimrc nnoremap <buffer><silent> <leader>c :<c-u>w <bar> so $MYVIMRC <bar> PlugClean<cr>
  augroup END
endif

function! s:is_plugged(name) abort
  if exists('g:plugs') && has_key(g:plugs, a:name) && isdirectory(g:plugs[a:name].dir)
    return 1
  else
    return 0
  endif
endfunction

function! s:set_ft_none() abort
  if @% == ""
    setlocal filetype=none
  endif
endfunction

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

if exists('&termguicolors')
  set termguicolors
  if exists('$TMUX')
    let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
    let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
  endif
  if !has('nvim')
    let &t_ZH="\e[3m"
    let &t_ZR="\e[23m"
  endif
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
  if g:colors_name == 'nord'
    highlight Comment term=italic cterm=italic gui=italic
  endif
  if g:colors_name == 'material' && g:material_theme_style == 'palenight'
  endif
endfunction

if s:is_plugged('nord-vim')
  colorscheme nord
endif

if s:is_plugged('material.vim')
  let g:material_terminal_italics = 1
  let g:material_theme_style = 'palenight'
  colorscheme material
endif

if s:is_plugged('vimdoc-ja')
  set helplang=ja
endif

if s:is_plugged('vim-molder')
  let g:molder_show_hidden = 1
  augroup pi_molder
    autocmd!
    autocmd FileType molder nmap <buffer> h <plug>(molder-up)
    autocmd FileType molder nmap <buffer> l <plug>(molder-open)
    autocmd FileType molder nmap <buffer> . <plug>(molder-toggle-hidden)
    autocmd FileType molder nnoremap <buffer><nowait> g gg
    autocmd FileType molder nnoremap <buffer> / /\c
  augroup END
endif

if s:is_plugged('vim-molder-operations')
  augroup pi_molder_operations
    autocmd!
    autocmd FileType molder nmap <buffer><nowait> d <plug>(molder-operations-newdir)
    autocmd FileType molder nmap <buffer> D <plug>(molder-operations-delete)
    autocmd FileType molder nmap <buffer> r <plug>(molder-operations-rename)
    autocmd FileType molder nnoremap <buffer> % :e %:p:h/
  augroup END
endif

if s:is_plugged('caw.vim')
  let g:caw_no_default_keymappings = 1
  let g:caw_hatpos_skip_blank_line = 1
  nmap gc <plug>(caw:hatpos:toggle:operator)
  xmap gc <plug>(caw:hatpos:toggle:operator)
  nmap <expr> gcc empty(trim(getline('.'))) ?
        \ "\<plug>(caw:hatpos:comment)" :
        \ "\<plug>(caw:hatpos:toggle)"
endif

if s:is_plugged('vim-textobj-entire')
  let g:textobj_entire_no_default_key_mappings = 1
  omap ie <plug>(textobj-entire-a)
  xmap ie <plug>(textobj-entire-a)
endif

if s:is_plugged('ultisnips')
  let g:UltiSnipsEditSplit = 'vertical'
  let g:UltiSnipsSnippetDirectories = ['~/.vim/ultisnips']
  let g:UltiSnipsSnippetAuthor = 'gairrr'
  nnoremap <silent> <leader>u :<c-u>UltiSnipsEdit<cr>
  augroup pi_ultisnips
    autocmd!
    autocmd FileType snippets set expandtab
    autocmd FileType scss nnoremap <buffer><silent> <leader>u :<c-u>UltiSnipsEdit css<cr>
    autocmd FileType scss nnoremap <buffer><silent> <leader>U :<c-u>UltiSnipsEdit scss<cr>
  augroup END
endif

if s:is_plugged('vim-rooter')
  let g:rooter_silent_chdir = 1
  let g:rooter_resolve_links = 1
  let g:rooter_change_directory_for_non_project_files = ''
endif

if s:is_plugged('fzf.vim')
  let g:fzf_layout = { 'down': '10%' }
  let g:fzf_preview_window = []
  let g:fzf_buffers_jump = 1
  nnoremap <silent><c-p> :<c-u>Files<cr>
endif

nnoremap <silent> <leader>v :<c-u>vs $MYVIMRC<cr>
nnoremap <silent> <leader>. :<c-u>so $MYVIMRC<cr>
nnoremap <silent> <leader>w :<c-u>up<cr>
nnoremap <silent> <leader>W :<c-u>wa<cr>
nnoremap <silent> <leader>q :<c-u>wq<cr>
nnoremap <silent> <leader>Q :<c-u>q!<cr>
nnoremap 0 ^
xnoremap 0 ^
onoremap 0 ^
nnoremap <silent> <c-w>H :<c-u>vs<cr>
nnoremap <silent> <c-w>J :<c-u>bel sp<cr>
nnoremap <silent> <c-w>K :<c-u>sp<cr>
nnoremap <silent> <c-w>L :<c-u>bel vs<cr>
cnoremap <c-b> <left>
cnoremap <c-n> <down>
cnoremap <c-p> <up>
cnoremap <c-f> <right>
cnoremap <c-a> <home>
cnoremap <c-d> <del>
cnoremap <c-k> <c-\>e getcmdpos() == 1 ?
      \ '' :
      \ getcmdline()[:getcmdpos()-2]<cr>

augroup ft_none
  autocmd!
  autocmd BufEnter * call s:set_ft_none()
  autocmd FileType none nnoremap <buffer> q :<c-u>q!<cr>
augroup END

augroup ft_gitcommit
  autocmd!
  autocmd FileType gitcommit nnoremap <buffer><silent> q :<c-u>wq<cr>
augroup END

augroup ft_help
  autocmd!
  autocmd FileType help nnoremap <buffer><silent> q :<c-u>q!<cr>
augroup END

augroup ft_css_scss
  autocmd!
  autocmd FileType css,scss nnoremap p p=']
  autocmd FileType css,scss xnoremap p p=']
  autocmd FileType css,scss nnoremap P P=']
  autocmd FileType css,scss xnoremap P P=']
  autocmd FileType css,scss nnoremap <silent> <c-a> <c-a>:w<cr>
  autocmd FileType css,scss nnoremap <silent> <c-x> <c-x>:w<cr>
augroup END
