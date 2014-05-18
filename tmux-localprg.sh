prgdir='~/git-repo/hd-prg'
tmux new -d -s localwork -n 'prg'
tmux send 'cd ' $prgdir 'C-m'
tmux send 'vim' 'C-m'
tmux splitw -t localwork -h -p 50 -c $prgdir

clientdir='~/git-repo/hd-prg/client'
tmux neww -t localwork:1 -n 'client' -c $clientdir
tmux send -t 1 'vim' 'C-m'
tmux splitw -t localwork:1 -h -l 60 -c $clientdir
tmux send -t localwork:1.1 './tail_ios_sim.sh' 'C-m'
tmux splitw -t localwork:1.1 -v -p 50 -c $clientdir
tmux send -t localwork:1.2 './tail_android_sim.sh' 'C-m'
tmux selectp -t 0

serverdir='~/git-repo/hd-prg/server'
tmux neww -P -t localwork:2 -n 'server' -c $serverdir 
tmux send -t 2 'vim' 'C-m'
tmux splitw -t localwork:2 -h -p 45 -c $serverdir 
tmux send './redis.sh' 'C-m' './nginx.sh' 'C-m' './taillog.sh' 'C-m'
tmux splitw -t localwork:2.1 -c $serverdir -h -p 50  #2.2
tmux send -t localwork:2.2 '../client/tail_ios_sim.sh' 'C-m'
tmux splitw -t localwork:2.2 -v -p 33 -c $serverdir #2.3
tmux send -t localwork:2.3 '../client/tail_android_sim.sh 1'
tmux splitw -t localwork:2.2 -v -p 50 -c $serverdir #2.4
tmux send -t localwork:2.4 '../client/tail_android_sim.sh 2'
tmux splitw -t localwork:2.1 -v -p 20 -c $serverdir #2.5
tmux send -t localwork:2.5 'rlwrap -a -- redis-cli' 'C-m'
tmux selectp -t 0

tmux neww -t localwork:3 -n 'cc' -c '~/git-repo/hd-cc'

tmux neww -t localwork:4 -n 'iossim'

tmux selectw -t 0
tmux attach
