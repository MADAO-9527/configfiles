set nocompatible
filetype off

"基础设置"
set encoding=utf-8
set showmode
set number
set ruler
set autoindent
set smartindent
set showcmd
set incsearch
set noswapfile
set background=light
set history=50
set shiftwidth=2
set softtabstop=2
set expandtab
%retab!
set cursorline
highlight CursorLine   cterm=NONE ctermbg=black ctermfg=NONE guibg=NONE guifg=NONE
syntax enable

"快捷键"
let mapleader=','
nnoremap Y y$
nnoremap <c-tab> :tabn<CR>
nnoremap , :
nnoremap ,q :q!<CR>
nnoremap ,w :w<CR>
nnoremap ,wq :wq<CR>
nnoremap ,qa :qall!<CR>
nnoremap ,wqa :wqall<CR>
nnoremap ,v <Esc>"+p
nnoremap ,n :tabnew<CR>
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap ,ss :set syntax=

"粘贴时不置换“剪贴板”
xnoremap p pgvy


"判断是否gvim,是就加载插件"
if has('gui_running')
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'
  Plugin 'scrooloose/nerdtree'
  Plugin 'vim-airline/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
  Plugin 'kien/ctrlp.vim'
  Plugin 'scrooloose/syntastic'
  Plugin 'jistr/vim-nerdtree-tabs'
  Plugin 'tpope/vim-surround'
  call vundle#end()
  filetype plugin indent on

  set guifont=Source\ Code\ Pro\ for\ Powerline\ 10
  colorscheme Tomorrow-Night
  set guioptions-=T
  set guioptions-=m
  set guioptions-=L
  set guioptions-=r
  set guioptions-=b
  " 使用内置 tab 样式而不是 gui
  set guioptions-=e
  set nolist

  "NERDTree"
  autocmd VimEnter * NERDTree
  wincmd w
  autocmd VimEnter * wincmd w
  function! CheckLeftBuffers()
    if tabpagenr('$') == 1
      let i = 1
      while i <= winnr('$')
        if getbufvar(winbufnr(i), '&buftype') == 'help' ||
            \ getbufvar(winbufnr(i), '&buftype') == 'quickfix' ||
            \ exists('t:NERDTreeBufName') &&
            \   bufname(winbufnr(i)) == t:NERDTreeBufName ||
            \ bufname(winbufnr(i)) == '__Tag_List__'
          let i += 1
        else
          break
        endif
      endwhile
      if i == winnr('$') + 1
        qall
      endif
      unlet i
    endif
  endfunction
  autocmd BufEnter * call CheckLeftBuffers()
  let NERDTreeShowHidden=1                            " 是否显示隐藏文件
  let NERDTreeIgnore=['\.pyc','\~$','\.swp']          " 忽略一下文件的显示
  let g:nerdtree_tabs_open_on_console_startup=1       " 设置打开vim的时候默认打开目录树

  "vim-airline"
  let g:airline_theme='bubblegum'
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#buffer_nr_show = 1
  let g:airline#extensions#whitespace#enabled = 0
  let g:airline#extensions#whitespace#symbol = '!'
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''

  "CtrlP"
  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmd = 'CtrlP'
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_show_hidden = 1

  "Syntastic"
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
endif
