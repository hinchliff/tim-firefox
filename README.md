The TIM Timekeeping app for UNC doesn't work correctly on modern Chrome (57) or Firefox (52) on Linux, but it did work on Firefox 49.  Running Firefox 49 locally, Firefox keeps insisting on updating to the latest version (maybe whenever you click About?).  A docker container locked at version 49 should have been easy to implement, but it's been tricky.

1. Need flash-plugin
1. Need to add Certificate Authorities

Using CCK2 has helped with that, but it still doesn't quite work correctly.  I'm giving up for now, and will just blow away local install and un-tar version 49 again when necessary...

## Current Status
CCK2 seems to add the flash-plugin and CAs correctly, and seems to adjusts other preferences (Don't Update!).  I can login and view the TIM application, but it looks like some Fonts are missing, and the drop-downs to select type of Leave taken is not working (which is the same behavior on up-to-date browsers, even though this works on Firefox 49 on the host).

## Running the Docker image
First, you will need to setup Xauthority on your host machine:
```
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
```

Run:
```
docker run -it \
    -v $XSOCK:$XSOCK \
    -v $XAUTH:$XAUTH \
    -e XAUTHORITY=$XAUTH \
    --ipc host  \
    hinchliff/tim-firefox bash
```


