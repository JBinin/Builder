# FROM nvidia/cuda:11.3.0-devel-ubuntu20.04
FROM nvcr.io/nvidia/tensorrt:21.05-py3
ENV DEBIAN_FRONTEND=noninteractive
#RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
#    sed -i s@/security.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN apt-get update
# opencv
RUN apt install libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev -y && \
    apt install python-dev-is-python3 python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev libtiff5-dev libx264-dev -y
RUN git clone https://github.com/opencv/opencv.git --depth 1 && \
    git clone https://github.com/opencv/opencv_contrib.git --depth 1
RUN cd opencv && \
    mkdir build ; cd build && \
    cmake -D WITH_FFMPEG=OFF -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules .. && \
    make -j$(nproc) && \
    make install -j$(nproc) && cd .. && rm -rf build && cd ..
# fmt
RUN git clone https://github.com/fmtlib/fmt.git --depth 1
RUN cd fmt && mkdir _build && cd _build && \
    cmake .. && make -j$(nproc) && make install -j$(nproc) && cd .. && rm -rf _build && cd ..

# folly
RUN apt install libgoogle-glog-dev libboost-all-dev libevent-dev libdouble-conversion-dev libgoogle-glog-dev -y && \
    apt install libgflags-dev libiberty-dev liblz4-dev liblzma-dev libsnappy-dev zlib1g-dev binutils-dev -y && \
    apt install libjemalloc-dev libssl-dev pkg-config libunwind-dev libunwind8-dev libelf-dev libdwarf-dev -y

RUN git clone https://github.com/facebook/folly.git && git checkout 530a7266f9f15eaad196ce1b291fbbfc8e578810
RUN cd folly && mkdir _build && cd _build && \
    cmake .. && make -j$(nproc) && make install -j$(nproc) && cd .. && rm -rf _build && cd ..

# yaml-cpp
RUN git clone https://github.com/jbeder/yaml-cpp.git --depth 1
RUN cd yaml-cpp && mkdir build ; cd build && cmake -DBUILD_SHARED_LIBS=ON .. && make -j$(nproc) && make install -j$(nproc) && \
    cd .. && rm -rf build && cd .. \

# onnx
RUN apt install libprotobuf-dev protobuf-compiler -ys
RUN git clone --recursive https://github.com/onnx/onnx.git --depth 1
RUN cd onnx && mkdir build ; cd build && cmake .. && make -j$(nproc) && make install -j$(nproc) && \
    cd .. && rm -rf build && cd ..

# libjpeg-turbo
RUN wget --content-disposition -c https://sourceforge.net/projects/libjpeg-turbo/files/2.1.3/libjpeg-turbo-official_2.1.3_amd64.deb
RUN dpkg -i libjpeg-turbo-official_2.1.3_amd64.deb && apt-get install -f && \
    rm -rf libjpeg-turbo-official_2.1.3_amd64.deb

ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/usr/local/lib/
ENV LD_RUN_PATH ${LD_RUN_PATH}:/usr/local/lib/
ENV DYLD_LIBRARY_PATH ${DYLD_LIBRARY_PATH}:/usr/local/lib/
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/opt/libjpeg-turbo/lib64/
ENV CPLUS_INCLUDE_PATH ${CPLUS_INCLUDE_PATH}:/opt/libjpeg-turbo/include/
CMD [ "/bin/bash"]
