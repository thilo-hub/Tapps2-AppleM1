#!/bin/sh

# Build the container like:
# docker build --platform linux/amd64 -t thiloj/tapps2 .

TOOL=Tapps2;
case "$1" in
    Winsol) shift
	    TOOL=Winsol;;
    Tapps2) shift;;
esac
    

set "$@" $PWD/.
MP="$1"
test -d "$MP" || MP="$(dirname "$MP")"
docker run -d  --rm  --platform linux/amd64 -ti -v $MP:/Work/Files -p 2222:22  --name Tapps2    thiloj/tapps2
sleep 3
DCONF=tapps2.config.tar.gz
echo "Load config"
test -f $DCONF && ssh -p 2222 Tapps2@localhost tar xf - < $DCONF
ssh -Y  -p 2222 Tapps2@localhost $TOOL
echo "Save config"
ssh -p 2222 Tapps2@localhost tar -cf - ".??*"  > $DCONF
docker kill Tapps2

exit;

# Would be nice if this would work:
#  -v $(dirname "$DISPLAY"):/tmp/socket  
# And then just 
docker run -d  --rm  --platform linux/amd64 -ti -v $(pwd):$(pwd) -p 2222:22  \
    -v $(dirname "$DISPLAY")=$(dirname "$DISPLAY") \
    -e DISPLAY=$DISPLAY --name Tapps2  --entrypoint Tapps2  thiloj/tapps2

# If think https://github.com/docker/for-mac/issues/483  explains its not coming on MacOs...

