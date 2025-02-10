# Docker image to lauch a gazebo environment with multiple ground robots (turtlebots) and aerial robots (pelicans)

## Preparation Checklist
- Install Docker Engine
    - Install Docker on Ubuntu: [Docker installation guide for Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
    - Check docker is properly setup on laptop: open a terminal and run
      ```
      docker run hello-world
      ```

### Clone the repository
  ```
  git clone https://github.com/achilleas2942/simulator_cbf.git
  ```

### Run the Gazebo world locally
- Go to the docker directory
  ```
  cd simulator_cbf/docker/
  ```
- Run the bash script file to launch the gazebo environment
  ```
  ./run_container.sh robots <specify_the_number_of_robot_pairs> ros_master_uri <specify_the_ros_master_uri_ip> ros_ip <specify_the_ros_ip>
  ```
  e.g.
  - ```
    ./run_container.sh robots 2 ros_master_uri 127.0.0.1 ros_ip 127.0.0.1
    ```
  - or
    ```
    ./run_container.sh
    ```

If you do not specify the parameters robots, ros_master_uri, and ros_ip, then the following default values will be selcted:
- robots 4
- ros_master_uri $(hostname -I | awk '{print $1}')
- ros_ip $(hostname -I | awk '{print $1}')
