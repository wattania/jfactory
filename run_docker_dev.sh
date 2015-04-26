HOST_PROJ=$(pwd)
HOST___RAILS_ROOT=$HOST_PROJ/rails
DOCKER_RAILS_ROOT=/opt/rails

docker run --rm -it \
 -h "jfactory-dev" \
 --volumes-from jfactory_data \
 -p 3000:3000 \
 -p 5432:5432 \
 -v /etc/localtime:/etc/localtime:ro \
 -v $HOST___RAILS_ROOT:$DOCKER_RAILS_ROOT \
 docker.io/wattania/jfactory:latest \
 /bin/bash