#!/bin/bash

TAG=$1

if [ -z "$TAG" ]; then
    echo "Usage $0 TAG"
    exit 1
else
    sed -iE "s|image: 271122/ali.viation:\w*|image: 271122/ali.viation:${TAG}|g" 1-deployment.yaml
fi