#!/bin/bash

mkdir build
cd build
cmake -DCMAKE_TOOLCHAIN_FILE=../arm.cmake ..
make
