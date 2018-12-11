#!/bin/bash

set -e

if [ ! -z "$NB_PASSWORD_HASH" ]; then
  NB_ARGS="--NotebookApp.password='${NB_PASSWORD_HASH}'" $NB_ARGS
fi

if [ ! -z "$NB_TOKEN" ]; then
  NB_ARGS="--NotebookApp.token='${NB_TOKEN}'" $NB_ARGS
fi

/home/user/anaconda3/bin/jupyter lab --ip=0.0.0.0 --port=8888 --no-browser $NB_ARGS


