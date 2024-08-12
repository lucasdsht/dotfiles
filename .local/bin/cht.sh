#!/bin/bash

languages=$(echo "c csharp nodejs nodeenv nodemon nvm python javascript typescript bash rust css kotlin" | tr " " "\n" )
core_utils=$(echo "find xargs sed awk" | tr " " "\n" )
selected=$(echo -e "$languages\n$core_utils" | fzf)

read -p "GIVE YOUR QUERY: " query

if echo "$languages" | grep -qs $selected; then
  tmux split-window -p 22 -h bash -c "curl cht.sh/$selected/$(echo "$query" | tr " " "+") | less -R"
else
  tmux split-window -p 22 -h bash -c "curl cht.sh/$selected~$query | less -R"
fi
