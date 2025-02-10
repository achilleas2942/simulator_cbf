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
if [[ "$NUM_ROBOTS" == "4" ]]; then
    echo "⚠️  WARNING: Using default: $NUM_ROBOTS"
fi

if [[ "$ROS_MASTER_IP" == "$ROS_IP" && "$ROS_MASTER_IP" == "$(hostname -I | awk '{print $1}')" ]]; then
    echo "⚠️  WARNING: Using default: $ROS_MASTER_IP"
fi

if [[ "$ROS_IP" == "$ROS_MASTER_IP" ]]; then
    echo "⚠️  WARNING: Using default: $ROS_IP"
fi

# Run the Docker container with the appropriate environment variables
docker run --privileged -it \
    --net=host \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    ghcr.io/achilleas2942/multiple_turtles_and_pelicans_simulator \
    "$NUM_ROBOTS" "$ROS_MASTER_IP" "$ROS_IP"