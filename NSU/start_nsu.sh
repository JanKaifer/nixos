XSOCK=/tmp/.X11-unix                                              
XAUTH=/tmp/.docker.xauth
CIDFILE=/tmp/.docker.nsu

xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

./stop_nsu.sh

echo Building container ...
docker build -t nsu - < ./Dockerfile

echo Starting container ...
docker run -t \
  -v "$XSOCK:$XSOCK" \
  -v "$XAUTH:$XAUTH" \
  -v /home:/home \
  -v /etc/passwd:/etc/passwd:ro \
  -v /etc/group:/etc/group:ro \
  -v /etc/shadow:/etc/shadow:ro \
  -v /etc/sudoers:/etc/sudoers:ro \
  -e "XAUTHORITY=$XAUTH" \
  --cidfile=$CIDFILE \
  nsu &