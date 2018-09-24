" python PIP 8 settings
" see: https://realpython.com/vim-and-python-a-match-made-in-heaven/
" see: https://www.python.org/dev/peps/pep-0008/?
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent
set fileformat=unix
set encoding=utf-8
" flag improper whitespaces
match BadWhitespace /\s\+$/
