#!/usr/bin/env bash

CUDA_ENV_FILE="/etc/profile.d/cuda.sh"

if [ ! -f $CUDA_ENV_FILE ]; then
    echo "CUDA_HOME=/usr/local/cuda" > $CUDA_ENV_FILE
    echo "CUDA_11_HOME=/usr/local/cuda-11" >> $CUDA_ENV_FILE
    echo "CUDA_12_HOME=/usr/local/cuda-12" >> $CUDA_ENV_FILE
fi
