FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu16.04

RUN echo deb http://archive.ubuntu.com/ubuntu precise universe multiverse >> /etc/apt/sources.list && \
apt update && apt install -y \
    build-essential \
    cmake \
    git \
    libusb-1.0.0-dev \
    libturbojpeg \
    libjpeg-turbo8-dev \
    libglfw3-dev \
    libopenni2-dev \
    #beignet-opencl-icd \
    clinfo \
    openni2-utils \
    pkg-config \
    #ocl-icd-libopencl1 \
    ocl-icd-opencl-dev \
    clinfo  \
    nvidia-modprobe \
    opencl-headers \
    udev

RUN git clone https://github.com/phuicy/libfreenect2.git \
    && cd libfreenect2 \
    && mkdir build && cd build \
    && cmake .. -DBUILD_OPENNI2_DRIVER=ON -DCMAKE_INSTALL_PREFIX=/root/freenect2 -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda -DCUDA_CUDART_LIBRARY=/usr/local/cuda/lib64/libcudart.so -DENABLE_CXX11=ON -DCUDA_PROPAGATE_HOST_FLAGS=off \
    && make \
    && make install \
    && apt-get install openni2-utils && make install-openni2 \ 
    && cp /libfreenect2/platform/linux/udev/90-kinect2.rules /etc/udev/rules.d/ \
    && ldconfig /root/freenect2 \
    && ln -s /libfreenect2/build/bin/Protonect /usr/local/bin/kinect_test \
    && apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./entry.bash /
ENTRYPOINT ["/entry.bash"]
