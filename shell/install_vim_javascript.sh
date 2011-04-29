#!/usr/bin/env bash
 
# - indent
# OP javascript indentation : This indentation script for OOP javascript (especially for EXTJS)
# http://www.vim.org/scripts/script.php?script_id=1936
echo "-install indent "
cd ~/.vim/indent || mkdir -p ~/.vim/indent
wget http://www.vim.org/scripts/download_script.php?src_id=7708 -O ~/.vim/indent/javascript.vim

# - syntax
# JavaScript syntax : Better JavaScrirpt syntax support
# http://www.vim.org/scripts/script.php?script_id=1491
echo "-install syntax"
cd ~/.vim/syntax || mkdir -p ~/.vim/syntax
wget http://www.vim.org/scripts/download_script.php?src_id=10728 -O ~/.vim/syntax/javascript.vim
