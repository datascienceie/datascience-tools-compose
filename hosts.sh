#!/bin/bash

for i in $(awk -F ":" '/frontend/{print $2}' docker-compose.yaml)
do
    echo "127.0.0.1        $i"
done
