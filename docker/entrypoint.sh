#!/bin/bash

# Source the ROS setup
source /opt/ros/noetic/setup.bash

# Pull the latest updates from the repositories
cd /root/catkin_ws/src
if [ -d "turtlebot3_simulations" ]; then
    cd turtlebot3_simulations && git pull && cd ..
else
    git clone https://github.com/achilleas2942/turtlebot3_simulations.git
fi

# Build the workspace
cd /root/catkin_ws/
catkin_make

# Source the workspace
source /root/catkin_ws/devel/setup.bash

# Make the launch script executable
roscd turtlebot3_gazebo/launch
chmod +x launch_robots.sh

# Export ROS_MASTER_URI
# export ROS_MASTER_URI=http://130.240.96.104:11311

# Automatically detect and export the host IP for ROS_IP
export ROS_IP=$(ip route | grep default | awk '{print $3}')

# pass gazebo args
export TURTLEBOT3_MODEL=waffle_pi

# Execute the provided command
roscd turtlebot3_gazebo/launch
./launch_robots.sh  "$1"

roslaunch turtlebot3_gazebo sim_launch.launch