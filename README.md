### Commands

_Note_: first check and modify _.env_ file

```.sh
# build libva, media driver, oneVPL and MediaSDK
docker-compose up vpl-builder

# runtime test libva and oneVPL
docker-compose up vpl-runner

# build OpenCV with oneVPL
docker-compose up opencv-builder

# run OpenCV videoio test
docker-compose up opencv-runner
```

Build OpenCV on host using media stack built by this project:
```.sh
docker-compose up vpl-builder
source env.sh

# cd <somwhere>
# build and test OpenCV on host as usual
```

_Note_: set `OPENCV_OPENCL_RUNTIME=disabled` to disable OpenCL runtime in OpenCV if you experience conflicts with media stack


### Contents

- **container/** - context and Dockerfile for an image used to build and run projects (single image for all)
- **sources/** - location for all soruces and build directories
- **install/** - install root for all projects, standard layout: _bin_, _include_, _lib_, etc.
- **.env** - file with some constants used by containers, modify it according to your system (user id, _video_ and _render_ group ids)
- **build-driver.sh** and **build-opencv.sh** - build scripts for media stack and OpenCV, will be run inside containers
- **env.sh** - helper environment set-up script for external usage
