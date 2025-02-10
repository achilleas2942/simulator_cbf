# Allow docker container to connect to the display server
xhost +local:docker

# Run the Docker container with the appropriate environment variables
docker run --privileged -it \
    --net=host \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    ghcr.io/achilleas2942/multiple_turtles_and_pelicans_simulator \
    6 130.240.96.104 130.240.96.104 # Change the number of robots, ROS_MASTER_IP, and ROS_IP as needed