"
" vim: set foldmarker={{,}} foldlevel=0 foldmethod=marker ts=2:
"
" --------------------------------------------------
"
"  per directory settings:
"
"  {
"
" Read: https://github.com/mantiz/vim-plugin-dirsettings
"
" > This is a simple plugin that allows per directory settings
" > for your favourite editor VIM.
"
" > dirsettings#Install() should be the very first command in your .vimrc
"
"call dirsettings#Install()
"
" }
"
" --------------------------------------------------
"
" simplify the standard messages (FIXME!)
"
" {
"set shortmess+=atI
":intro
"
" }
"
" --------------------------------------------------
"
" standard prelude: Identify platform
"
" {
" source: https://github.com/spf13/spf13-vim
silent function! s:is_osx()
	return has('macunix')
endfunction
silent function! s:is_linux()
	return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! s:is_windows()
	return  (has('win32') || has('win64'))
endfunction
"
" running in standalone GUI?
silent function! s:is_gui()
	return has('gui_running')
endfunction
"
" this is the most common way to run VIM in my PC: in a Terminal under X11
silent function! s:is_xterm()
	return has('unix') && (&term =~ 'xterm') && !s:is_gui()
endfunction
" }
"
" --------------------------------------------------
"
" standard prelude: calculate platform specific paths
"
" {
"
" \func s:vimfile() - calculate the path to a config file under ~/.vim
"
" NOTE: internally on this script, you must always use Unix/Linux/OSX style
" filenames. In the case of run under Windows, this function translate them
" to the local format.
silent function! s:vimfile(filename)
	if s:is_windows()
		return '~\\vimfiles\\' . a:filename
	else
		return '~/.vim/' . a:filename
	endif
endfunction
" }
"
" --------------------------------------------------
"
" Install Pathogen, a plugin manager for VIM (DISABLED))
"
" {
"
" doesn't make a lot of sense run two package manager
" so I disable pathogen and let plug-vim do the work below
let g:use_pathogen = 0
"
" only if active
if g:use_pathogen
	execute pathogen#infect()
endif
"
" }
"
" --------------------------------------------------
"
" Install plugins with plug-vim, a plugin manager for VIM
"
" My plugins {
"
let g:use_plug_vim = 1
if g:use_plug_vim
	call plug#begin(s:vimfile('plugged'))

	" UI-UX
	" ==================================================
	"
	" many colour schemes
	Plug 'rafi/awesome-vim-colorschemes'
	" status bar with themes
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	" spacemacs keybindings
	" see: http://spacemacs.org
	" see: https://github.com/jimmay5469/vim-spacemacs
	Plug 'jimmay5469/vim-spacemacs'

	" Project Management
	" ==================================================
	"
	" see: https://vimawesome.com/plugin/ctrlp-vim-red
	" see: http://ctrlpvim.github.io/ctrlp.vim
	Plug 'ctrlpvim/ctrlp.vim'
	" GIT integration
	Plug 'tpope/vim-fugitive'
	" mercurial integration
	" see: https://bolt80.com/lawrencium/
	Plug 'ludovicchabant/vim-lawrencium'

	" Markdown and prosa texts
	" ==================================================
	"
	" distraction-free mode
	Plug 'junegunn/goyo.vim'
	" improve how the cursor moves in prosa files
	Plug 'reedes/vim-pencil'
	" move text into tables
	Plug 'godlygeek/tabular'
	" improve support for markdown
	Plug 'plasticboy/vim-markdown'

	" HTML/XML
	" ==================================================
	"
	" emmet for VIM
	Plug 'mattn/emmet-vim'

	" Standard ML
	" ==================================================
	"
	" improve support for Standard ML
	Plug 'jez/vim-better-sml'

	" Python
	" ==================================================
	"
	" improved python indenting
	" see: https://realpython.com/vim-and-python-a-match-made-in-heaven/
	Plug 'vim-scripts/indentpython.vim'

	" General programming tools
	" ==================================================
	"
	" snitmate support
	" see https://github.com/garbas/vim-snipmate
	Plug 'MarcWeber/vim-addon-mw-utils'
	Plug 'tomtom/tlib_vim'
  " deprecate:	Plug 'garbas/vim-snipmate'
	" templates
	Plug 'aperezdc/vim-template'
	" interactive development (invoked externally as «codi»)
	" see: https://github.com/metakirby5/codi.vim
	Plug 'metakirby5/codi.vim'

	call plug#end()
endif
"
" }
"
" --------------------------------------------------
"
" my preferences for global options
"
" {
"
set nocompatible
syntax on
set tabstop=8
"set shiftwidth=4
"set cursorline
set wildmenu
set esckeys
set backspace=indent,eol,start
set modelines=5
filetype plugin on
set splitbelow
set splitright
set hidden
set mouse=a
set history=1000
" this fix the switch/case indentation in C files
set cinoptions=:0
"
" }
"
" --------------------------------------------------
"
" 'Q' should be the same as 'q'
"
" {
:command Q q
:command W w
:command WQ wq
" }
"
" --------------------------------------------------
"
" some options got different values on gui mode
"
" {
"
" I always run VIM in GUI mode under Windows
if s:is_windows()
	set guifont=Console
	set lines=30 columns=110
endif
" same with macOS
" TODO: test this in macOS. It has a pretty good console
"       so a term mode is not stretch too far
if s:is_osx()
	set guifont=Monaco
	set lines=30 columns=110
endif
" Linux ath the other hand, has three modes:
" 	A) GUI;
" 	B) non GUI in X11 and;
" 	C) non GUI in console.
if s:is_linux()
	if has('gui_running')
		set guifont=Hack
		set guioptions-=m
		set background=dark
		colorscheme molokai
	elseif s:is_xterm()
		set background=dark
		colorscheme molokai
	else
		set background=dark
		colorscheme gotham
		"colorscheme default
	endif
endif
"
" TODO: test this with another operating system.
"       I'm looking to you, OpenBSD
"
" }
"
" --------------------------------------------------
"
" splits and folds
"
 " {
"
" these instructions simplify movement through splits
"
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"
" and improve handle of folds
set foldmethod=syntax
set foldlevel=99
"nnoremap <space> za
"
" source: https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/
"
"  }
"
" --------------------------------------------------
"
"  spacemacs keybindings
"
let g:spacemacs#leader = '<SPACE>'
let g:spacemacs#plugins = [ 'kien/ctrlp', 'tpope/vim-fugitive' ]
let g:spacemacs#excludes = [ '^bb', '^fed', '^feR' ]
:nnoremap <SPACE>bb  :buffers<CR>:buffer<Space>
:nnoremap <SPACE>fed :e ~/.vim/vimrc<CR>
:nnoremap <SPACE>feR :source ~/.vim/vimrc<CR>
"
" --------------------------------------------------
"
" keep state betweed sessions
"
" {
"
" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
"
" source: http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
"
set viminfo='10,\"100,:20,%,n~/.vim/viminfo
"
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction
"
augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END
"
" }
" 
" --------------------------------------------------
"
" centralize backups, swapfiles and undo history
"
" {
"
execute "set backupdir=" . s:vimfile("backups")
execute "set directory=" . s:vimfile("swaps")
if exists("&undodir")
	execute "set undodir=" . s:vimfile("undo")
endif
"
" source: http://timreynolds.org/2013/05/26/configuring-vim-on-mac-os-x/
"
" TODO: the call to s:vimfile() is my change. I need to research
"       for a better way to assigna function's return to a set command
" }
"
" --------------------------------------------------
"
"  configure vim-template
"
"  {
"
"  FIXME: the template is loaded twice if g:templates_no_autocmd=0
"         as workaround I limit the template system to use on demand
"
let g:templates_no_autocmd=1
let g:templates_directory=s:vimfile("templates")
let g:templates_global_name_prefix="skeleton"
let g:templates_no_builtin_templates=1
let g:username="Iván Garcerant"
let g:email="igarcerant@gmail.com"
let g:license="Propietary"
let g:templates_debug=0
"
" }
"
" --------------------------------------------------
"
" configure netrw
"
" { 
"
" see https://shapeshed.com/vim-netrw/
"
let g:netrw_no_autocmd = 1
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 0
let g:netrw_winsize = 25
"
" open current working directory in netrw
nnoremap <C-\> :Vexplore<CR>
"
" open Works in netrw.
if s:is_linux() || s:is_osx()
" Linux/macOS currently on $HOME
	nnoremap <C-a> :Vexplore ~/Works<CR>
elseif s:is_windows()
" On Windows, Works is under OneDrive control
	nnoremap <C-a> :Vexplore C:\\Users\\Ivan\\OneDrive\\Works
endif
"
" I toyed with the idea to open netrw at startup
" now this is controlled by the variable g:netrw_no_autocmd
if !g:netrw_no_autocmd
	augroup ProjectDrawer
		autocmd!
		autocmd VimEnter * :Vexplore
		autocmd VimEnter * wincmd l
	augroup END
endif
"
" }
"
" --------------------------------------------------
"
" configure vim-airline
"
" {
let g:airline_detect_spell=1
let g:airline_detect_spelllang=1
"
" if you want to patch the airline theme before it gets applied,
" you can supply the name of a function where you canmodify the paletter.
"
"let g:airline_theme_path_func='MyAirlineThemePatch'
"function! MyAirlineThemePatch(palette)
"  if g:airline_theme == 'badwolf'
"    for colors in values(a:palette.inactive)
"      let colors[3] = 245
"    endfor
"  endif
"endfunction
"
" themes are automatically selected based on the matching colorscheme
" this can be overridden by defining a value.
"
"let g:airline_theme='dark'
"
" }
"
" --------------------------------------------------
"
" enable per-project initialization (DISABLED)
"
" {
"
" NOTE: vainilla VIM support per-folder initialization,
"       so I use it to get an initial version of this
"
"       these two settings (exrc and secure) work best
"       at the end of vimrc; b/c these affect too many things
"
"set exrc
"set secure
"
" }
"
" --------------------------------------------------
"
