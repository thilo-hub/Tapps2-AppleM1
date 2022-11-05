#!/bin/sh

# Build the container like:
# docker build --platform linux/amd64 -t thiloj/tapps2 .

set "$@" $PWD/.
MP="$1"
test -d "$MP" || MP="$(dirname "$MP")"
docker run -d  --rm  --platform linux/amd64 -ti -v $MP:/Work/Files -p 2222:22  --name Tapps2    thiloj/tapps2
sleep 3
ssh -Y  -p 2222 Tapps2@localhost Tapps2
docker kill Tapps2

exit;

# Would be nice if this would work:
#  -v $(dirname "$DISPLAY"):/tmp/socket  
# And then just 
docker run -d  --rm  --platform linux/amd64 -ti -v $(pwd):$(pwd) -p 2222:22  \
    -v $(dirname "$DISPLAY")=$(dirname "$DISPLAY") \
    -e DISPLAY=$DISPLAY --name Tapps2  --entrypoint Tapps2  thiloj/tapps2

# If think https://github.com/docker/for-mac/issues/483  explains its not coming on MacOs...

