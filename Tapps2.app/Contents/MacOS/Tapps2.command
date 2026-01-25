#!/bin/sh
(env
set -vx
echo "Myself: $0"
APP=$(dirname "$0")
BASE="$APP/..";

DCONF="$BASE/Resources"
test -d "$DCONF" || mkdir "$DCONF"
# We are storing preferences in the tar archive as the docker is volatile
DCONF="$DCONF/tapps2.config.tar.gz"

ls -la $(dirname "$0")
ls -ltra  
cd $(dirname "$0")
# Im not sure if this is the best way to use docker - maybe there is a better one?
DOCKER_BIN=$(mdfind 'kMDItemCFBundleIdentifier == "com.docker.docker"' | grep '/Docker.app$' | head -1)/Contents/Resources/bin
PATH=$DOCKER_BIN:$PATH

# Build the container like:
# docker build --platform linux/amd64 -t thiloj/tapps2 .

TOOL=Tapps2;
case "$1" in
    Winsol) shift
	    TOOL=Winsol;;
    Tapps2) shift;;
esac
    
#Either a specified directory as the base or use $HOME"
set "$@" "$HOME"
MP="$1"
test -d "$MP" || MP="$(dirname "$MP")"
docker run -d  --rm  --platform linux/amd64 -ti -v "$MP:/Work/Files" -p 2222:22  --name Tapps2    thiloj/tapps2
sleep 3
echo "Load config"
test -f $DCONF && ssh -p 2222 Tapps2@localhost tar xf - < $DCONF
ssh -Y  -p 2222 Tapps2@localhost $TOOL
echo "Save config"
ssh -p 2222 Tapps2@localhost tar -cf - ".??*"  > $DCONF
pkill quartz &
docker kill Tapps2

wait
exit;

# Would be nice if this would work:
#  -v $(dirname "$DISPLAY"):/tmp/socket  
# And then just 
docker run -d  --rm  --platform linux/amd64 -ti -v $(pwd):$(pwd) -p 2222:22  \
    -v $(dirname "$DISPLAY")=$(dirname "$DISPLAY") \
    -e DISPLAY=$DISPLAY --name Tapps2  --entrypoint Tapps2  thiloj/tapps2

# If think https://github.com/docker/for-mac/issues/483  explains its not coming on MacOs...
)  >/tmp/b.env 2>&1

