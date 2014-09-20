OS=$(uname)
prgdir='~/git-repo/hd-prg'
tmux new -d -s localwork -n 'prg'
tmux send 'cd ' $prgdir 'C-m'
tmux send 'vim' 'C-m'
tmux splitw -t localwork -h -p 50 -c $prgdir

clientdir='~/git-repo/hd-prg/client'
tmux neww -t localwork:1 -n 'client' -c $clientdir
tmux send -t 1 'vim' 'C-m'
tmux splitw -t localwork:1 -h -l 60 -c $clientdir  #1.1
if [ "$OS" == "Darwin" ] ;then
tmux send -t localwork:1.1 './tail_mac.sh 1' 'C-m'
else
tmux send -t localwork:1.1 './tail_android_sim.sh' 'C-m'
fi
tmux selectp -t 0

serverdir='~/git-repo/hd-prg/server'
tmux neww -P -t localwork:2 -n 'server' -c $serverdir 
tmux send -t 2 'vim' 'C-m'
tmux splitw -t localwork:2 -h -p 45 -c $serverdir 
tmux send './redis.sh' 'C-m' './nginx.sh' 'C-m' './taillog.sh' 'C-m'
tmux splitw -t localwork:2.1 -c $serverdir -h -p 50  #2.2
if [ "$OS" == "Darwin" ] ;then
tmux send '../client/tail_mac.sh 1' 'C-m'
else
tmux send '../client/tail_android_sim.sh 1'
fi
tmux splitw -t localwork:2.2 -v -p 50 -c $serverdir #2.3
if [ "$OS" == "Darwin" ] ;then
tmux send '../client/tail_mac.sh 2' 'C-m'
else
tmux send '../client/tail_android_sim.sh 2'
fi
tmux selectp -t 0

tmux neww -t localwork:3 -n 'redis'
tmux send 'rlwrap -a -- redis-cli' 'C-m'
tmux splitw -t localwork:3 -h -p 50

tmux neww -t localwork:4 -n 'cc' -c '~/git-repo/hd-cc'
tmux neww -t localwork:5 -n 'simdata'

tmux selectw -t 0
tmux attach
