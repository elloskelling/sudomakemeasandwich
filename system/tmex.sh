#!/bin/sh 
# Usage: tmex "command [args]" "[file-to-edit]"
#
# Starts a tmux session with two windows for REPL development
# Requires https://github.com/tpope/vim-tbone
# Right window will hold the REPL (or whatever command you specify)
# Left window will open nvim with whatever file you specify (or empty to open vim browser)
# Once in nvim, use <Leader>r to send current line or visual block to the REPL
# --- if you have unimatrix, try the below line for extra fun
# tmux new-session "unimatrix.py -s96 -lggCCk -wfi -t 1; $1" \; \
tmux new-session "$1" \; \
	split-window -bh nvim \
             "+nnoremap <silent> <Leader>r :silent .Twrite {right} <bar> +<CR>" \
             "+xnoremap <silent> <Leader>r :<C-u>silent '<,'>Twrite {right} <bar> '>+<CR>" \
             "+set nospell" \
             "+0" \
	     "$2"

# zsh_completion
# _tmex() {
#   _arguments \
#     '1: :_path_commands' \
#     '2: :_files'
# }
#
# compdef _tmex tmex
