cmake_minimum_required(VERSION 3.0)
project(Inference)

set(CMAKE_CXX_STANDARD 17)

# Libraries
find_package(OpenCV REQUIRED)
find_package(JPEG REQUIRED)
find_package(CUDA REQUIRED)
find_package(Protobuf REQUIRED)
find_package(OpenMP REQUIRED)
find_package(yaml-cpp REQUIRED)

## Folly
find_package(folly REQUIRED)
include(cmake/FindGlog.cmake)
include(cmake/FindDoubleConversion.cmake)
find_package(fmt REQUIRED)

## TensorRT
include(cmake/FindTensorRT.cmake)

## ONNX
find_library(ONNX_LIB onnx)
find_library(ONNX_PROTO_LIB onnx_proto)
find_path(ONNX_INCLUDE onnx)

## nvinfer
find_library(NVINFER_LIB nvinfer ${TensorRT_LIBRARY})
find_library(NVONNX_LIB nvonnxparser ${TensorRT_LIBRARY})
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DONNX_ML=1 -O3")

set(ALL_LIBS
        ${OpenCV_LIBS} ${JPEG_LIBRARIES} ${CUDA_LIBRARIES}
        yaml-cpp
        ${Protobuf_LIBRARIES} folly fmt
        ${GLOG_LIBRARIES} ${DOUBLE_CONVERSION_LIBRARY}
        ${ONNX_LIB} ${ONNX_PROTO_LIB}
        ${NVINFER_LIB} ${NVONNX_LIB}
        "stdc++fs")
# My code
include_directories("include")
file(GLOB SOURCES "src/*.cc")
# This _must_ be STATIC due to CUDA fuckery
add_library(trt_common STATIC ${SOURCES})
target_link_libraries(trt_common PUBLIC OpenMP::OpenMP_CXX)
target_include_directories(trt_common PUBLIC ${OpenCV_INCLUDE_DIRS} ${JPEG_INCLUDE_DIRS} ${CUDA_INCLUDE_DIRS})

add_executable(Inference runner.cc)
target_link_libraries(Inference PUBLIC OpenMP::OpenMP_CXX trt_common ${ALL_LIBS})
target_include_directories(Inference PUBLIC ${ONNX_INCLUDE})