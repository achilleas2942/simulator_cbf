#!/bin/bash

# Source the ROS setup
source /opt/ros/noetic/setup.bash

# Set the parameter
NUM_ROBOTS=${1:-4}
ROS_MASTER_IP=${2:-$(hostname -I | awk '{print $1}')}
ROS_IP=${3:-$ROS_MASTER_IP}

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

roscd turtlebot3_description/urdf
mv turtlebot3_waffle_pi.urdf.xacro test.urdf.xacro
cp /root/catkin_ws/src/turtlebot3_simulations/turtlebot3_gazebo/urdf/turtlebot3_waffle_pi.urdf.xacro .

# Export ROS_MASTER_URI and ROS_IP
export ROS_MASTER_URI=http://"$ROS_MASTER_IP":11311
export ROS_IP="$ROS_IP"

# pass gazebo args
export TURTLEBOT3_MODEL=waffle_pi

# Execute the provided command
roscd turtlebot3_gazebo/launch
./launch_robots.sh  "$NUM_ROBOTS"

roslaunch turtlebot3_gazebo sim_launch.launch
