cmake \
  -D JPEG_LIBRARY=/local/lib/libjpeg.so \
  -D JPEG_INCLUDE_DIR=/local/include/ \
  -D FOLLY_ROOT_DIR=/local/ \
  -D TensorRT_LIBRARY=/usr/local/cuda/TensorRT-5.1.5.0/lib \
  -D TensorRT_INCLUDE_DIR=/usr/local/cuda/TensorRT-5.1.5.0/include \
  ..
