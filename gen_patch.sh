i=0
for c in `git log --author=wellbye | grep ^commit | awk '{print $2}'`; do
    git format-patch "$c^!" "$c";
    (( i= i+1 ))
    echo $i
    fn=`echo *.patch`
    mv $fn patch/`printf "%02d" $i`-$fn

done
