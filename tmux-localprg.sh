tmux new-session -d -s localwork -n 'prg'
tmux send-keys 'cd ~/git-repo/hd-prg' 'C-m'

tmux new-window -t localwork:1 -n 'client'
tmux send-keys 'cd ~/git-repo/hd-prg/client' 'C-m'
tmux split-window -t localwork:1 -h -l 60
tmux send-keys -t localwork:1.1 'cd ~/git-repo/hd-prg/client' 'C-m'
tmux split-window -t localwork:1.1 -v -l 20
tmux send-keys -t localwork:1.2 'cd ~/git-repo/hd-prg/client' 'C-m'

tmux new-window -t localwork:2 -n 'server'
tmux send-keys 'cd ~/git-repo/hd-prg/server' 'C-m'
tmux split-window -t localwork:2 -h -l 60
tmux send-keys -t localwork:2.1 'cd ~/git-repo/hd-prg/server' 'C-m'
tmux send-keys -t localwork:2.1 'tail -f ~/tmp/hdgsnginx/logs/error.log' 'C-m'
tmux split-window -t localwork:2.1 -v -l 20
tmux send-keys -t localwork:2.2 'cd ~/git-repo/hd-prg/server' 'C-m'
tmux send-keys -t localwork:2.2 './redis.sh' 'C-m'
tmux send-keys -t localwork:2.2 './nginx.sh' 'C-m'

tmux new-window -t localwork:3 -n 'cc'
tmux send-keys 'cd ~/git-repo/hd-cc' 'C-m'

tmux new-window -t localwork:4 -n 'iossim'
tmux attach
