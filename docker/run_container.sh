# Allow docker container to connect to the display server
xhost +local:docker

# Default values
NUM_ROBOTS=4
ROS_MASTER_IP="130.240.96.104"
ROS_IP="130.240.96.104"

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        robots) NUM_ROBOTS="$2"; shift 2;;
        ros_master) ROS_MASTER_IP="$2"; shift 2;;
        ros_ip) ROS_IP="$2"; shift 2;;
        *) echo "Unknown option: $1"; exit 1;;
    esac
done

# Run the Docker container with the appropriate environment variables
docker run --privileged -it \
    --net=host \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    ghcr.io/achilleas2942/multiple_turtles_and_pelicans_simulator \
    "$NUM_ROBOTS" "$ROS_MASTER_IP" "$ROS_IP"