echo "--------------------------------------------------------------"
echo " Building Multiple Turtles and Pelicans Simulator docker image"
echo "--------------------------------------------------------------"

DOCKER_BUILDKIT=1 docker build -t ghcr.io/achilleas2942/multiple_turtles_and_pelicans_simulator .