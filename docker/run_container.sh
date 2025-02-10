#!/bin/bash

# Allow docker container to connect to the display server
xhost +local:docker

# Default values
NUM_ROBOTS=4
ROS_MASTER_IP=$(hostname -I | awk '{print $1}')
ROS_IP=$ROS_MASTER_IP

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        robots) NUM_ROBOTS="$2"; shift 2;;
        ros_master_uri) ROS_MASTER_IP="$2"; shift 2;;
        ros_ip) ROS_IP="$2"; shift 2;;
        *) echo "Unknown option: $1"; exit 1;;
    esac
done

# Display warnings if default values are used
if [[ -z "$1" ]]; then
    echo "WARNING: Number of robots not specified. Using default: $NUM_ROBOTS"
fi

if [[ -z "$2" ]]; then
    echo "WARNING: ROS_MASTER_IP not specified. Using default: $ROS_MASTER_IP"
fi

if [[ -z "$3" ]]; then
    echo "WARNING: ROS_IP not specified. Using default: $ROS_IP"
fi

# Run the Docker container with the appropriate environment variables
docker run --privileged -it \
--net=host \
--env="DISPLAY" \
--env="QT_X11_NO_MITSHM=1" \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
ghcr.io/achilleas2942/multiple_turtles_and_pelicans_simulator \
"$NUM_ROBOTS" "$ROS_MASTER_IP" "$ROS_IP"