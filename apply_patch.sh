for ((k=52; k>=30; k--)); do
    num=`printf "%02d" $k`
    fn=`echo ../ccpatch/patch/$num-*`
    if [ -f $fn ]; then
        echo $k, $fn
    fi
    git apply -v --ignore-space-change --ignore-whitespace $fn
done
