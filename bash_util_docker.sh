
function mk8
{
    cmd=$1
    #echo $1
    if [ $cmd == "env" ]; then
        echo 'eval docker-env'
        eval $(minikube docker-env)
    elif [ $cmd == "web" ]; then
        echo 'k8s dashboard'
        minikube dashboard
    else
        minikube --logtostderr $@
    fi
}

function docker-show-tags
{
    if [ $# -lt 1 ]
    then
        cat << HELP

    dockertags  --  list all tags for a Docker image on a remote registry.

    EXAMPLE: 
        - list all tags for ubuntu:
               dockertags ubuntu

        - list all php tags containing apache:
               dockertags php apache

HELP
    return 
    fi

    image="$1"
    tags=`wget -q https://registry.hub.docker.com/v1/repositories/${image}/tags -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}'`

    if [ -n "$2" ]
    then
        tags=` echo "${tags}" | grep "$2" `
    fi

    echo "${tags}"
}

function docker-show-tags-v2
{
    for Repo in $* ; do
        curl -s -S "https://registry.hub.docker.com/v2/repositories/library/$Repo/tags/" | \
            sed -e 's/,/,\n/g' -e 's/\[/\[\n/g' | \
            grep '"name"' | \
            awk -F\" '{print $4;}' | \
            sort -fu | \
            sed -e "s/^/${Repo}:/"
    done
}

function docker-reset-env
{

    unset DOCKER_TLS_VERIFY
    unset DOCKER_CERT_PATH
    unset DOCKER_MACHINE_NAME
    unset DOCKER_HOST
}
