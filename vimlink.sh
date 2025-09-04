#!/usr/bin/bash

# 1. tmux list panes
panes=$(tmux list-panes)
#echo $panes > /tmp/tmux-test.txt
echo $panes > /tmp/hello
# 2. tmux for each pane get contents 
# 3. save buffers
# 4. create new window open exact split
# 5. paste correspondent buffers
#


for pane_id in $(tmux list-panes -a -F "#{pane_id}"); do
	tmux list-panes -t "$pane_id" -F "#{pane_left}-#{pane_width}x#{pane_top}-#{pane_height}" >> result.txt
	tmux capture-pane -t $pane_id -p >> result.txt
	echo "===END===" >> result.txt
done


