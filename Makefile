.PHONY: all help install

#
#
TRIVIAL_BACKUP= \
	@if test -e $(1) ; \
	then \
		echo "backuping $(1)" ; \
		rm -f $(1).bak ; \
		mv $(1) $(1).bak || exit 1 ; \
	fi

#
#
LINKING= \
	@echo "linking $(2) to this repository" ; \
	D=`pwd`/$(1) ; ( cd ~ ; ln -s "$$D" $(2) || exit 1 )

all: help

help:
	@echo 'use «make install» to install this vim configuration into your system'

install:
	$(call TRIVIAL_BACKUP,~/.vimrc)
	$(call TRIVIAL_BACKUP,~/.vim)
	mkdir ~/.vim
	$(call LINKING,vimrc,~/.vim/vimrc)
	mkdir ~/.vim/autoload
	$(call LINKING,autoload/plug.vim,~/.vim/autoload/plug.vim)
	mkdir ~/.vim/backups
	mkdir ~/.vim/ftdetect
	$(call LINKING,ftdetect/mom.vim,~/.vim/ftdetect/mom.vim)
	mkdir ~/.vim/ftplugin
	$(call LINKING,ftplugin/lisp.vim,~/.vim/ftplugin/lisp.vim)
	$(call LINKING,ftplugin/python.vim,~/.vim/ftplugin/python.vim)
	$(call LINKING,ftplugin/sml.vim,~/.vim/ftplugin/sml.vim)
	mkdir ~/.vim/plugged
	mkdir ~/.vim/snippets
	$(call LINKING,snippets/c.snippets,~/.vim/snippets/c.snippets)
	mkdir ~/.vim/swaps
	mkdir ~/.vim/syntax
	$(call LINKING,syntax/mom.vim,~/.vim/syntax/mom.vim)
	mkdir ~/.vim/templates
	$(call LINKING,templates/skeleton.c,~/.vim/templates/skeleton.c)
	$(call LINKING,templates/skeleton.h,~/.vim/templates/skeleton.h)
	$(call LINKING,templates/skeleton.make,~/.vim/templates/skeleton.make)
	mkdir ~/.vim/undo
	@echo 'NOTICE: to finish this installation, please run:'
	@echo ''
	@echo ' $$ vim +PlugInstall'
	@echo ''
	@echo 'This should install any third-paty code or plugin'
	@echo ''


