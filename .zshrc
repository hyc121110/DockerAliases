# images
driall() { docker rmi $(docker images -q); }

function dii-fn { docker image inspect $1 }
function dih-fn { docker image history $1 }
function dils-fn { docker image ls }
function dib-fn { docker image build $* }
function dit-fn { docker image tag $* }
function dip-fn { docker image push $* }
function dirm-fn { docker image rm $* }

# containers
dcrmall() { docker container rm $* $(docker ps -q -a); }

function dcip-fn {
    echo "IP addresses of all named running containers"
    OUT=""
    for DOC in `dnames-fn`
    do
        IP=`docker container inspect $DOC | grep -m3 IPAddress | cut -d '"' -f 4 | tr -d "\n"`
        OUT+=$DOC'\t'$IP'\n'
    done
    echo $OUT|column -t
}

function dnames-fn {
  for ID in `docker container ls | awk '{print $1}' | grep -v 'CONTAINER'`
  do
      docker container inspect $ID | grep Name | head -1 | awk '{print $2}' | sed 's/,//g' | sed 's%/%%g' | sed 's/"//g'
  done
}

function dci-fn {
  docker container inspect $1
}

function dcl-fn {
  docker container logs $*
}

function dcls-fn {
  docker container ls
}

function dclsa-fn {
  docker container ls -a
}

function dcex-fn { # for running containers
  docker container exec -it $1 ${2:-bash}
}

function dcrun-fn {
  docker container run -d $*
}

function dcrunrm-fn { # stop container after exiting
  docker container run -it --rm $1 ${2:-bash}
}

function dcrm-fn {
  docker container rm $*
}

# volumes
function dvls-fn { docker volume ls }
function dvi-fn { docker volume inspect $1 }
function dvp-fn { docker volume prune }
function dvr-fn { docker volume rm $* }
function dvc-fn { docker volume create $1 }

alias dii=dii-fn
alias dih=dih-fn
alias dils=dils-fn
alias dib=dib-fn
alias dit=dit-fn
alias dip=dip-fn
alias dirm=dirm-fn
alias dvls=dvls-fn
alias dvi=dvi-fn
alias dvp=dvp-fn
alias dvr=dvr-fn
alias dvc=dvc-fn
alias dcip=dcip-fn
alias dci=dci-fn
alias dcl=dcl-fn
alias dcls=dcls-fn
alias dclsa=dclsa-fn
alias dcex=dcex-fn
alias dcrun=dcrun-fn
alias dcrunrm=dcrunrm-fn
alias dcrm=dcrm-fn