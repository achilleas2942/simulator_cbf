# Use the base ROS Noetic core image
FROM achilleas2942/aerotrain-hri-gazebo:latest

# Update required dependencies
RUN apt-get update

# Install additional ROS packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-noetic-tf2 \
    ros-noetic-tf \
    ros-noetic-tf-conversions \
    ros-noetic-turtlebot3 \ 
    ros-noetic-turtlebot3-msgs \
    && rm -rf /var/lib/apt/lists/*

RUN rm /root/catkin_ws/src/rotors_simulator/rotors_description/urdf/pelican.xacro
COPY ./pelican.xacro /root/catkin_ws/src/rotors_simulator/rotors_description/urdf/pelican.xacro 
COPY ./hummingbird.xacro /root/catkin_ws/src/rotors_simulator/rotors_description/urdf/hummingbird.xacro

# Create an entrypoint script to pull the latest updates and build the workspace
COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

# Source ROS setup scripts
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN echo "source /root/catkin_ws/devel/setup.bash" >> ~/.bashrc

# Set the entrypoint
ENTRYPOINT ["/root/entrypoint.sh"]

# Default command (can be overridden)
CMD ["bash"]
