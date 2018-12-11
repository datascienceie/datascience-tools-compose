# Starting Jupyter notebook, available at jupyter.docker.localhost


```
# Start Jupyter notebook
docker-compose -f docker-compose.yaml up jupyter
```

> Default password is `password` and can be configured through `config/jupyter.env`


# Building / customizing Jupyter:

```
vim services/jupyter/Dockerfile
docker-compose -f docker-compose.yaml build jupyter
```

# Setting up persistent storage with Minio and RexRay:
```
docker plugin install rexray/s3fs \
  S3FS_OPTIONS="allow_other,use_path_request_style,nonempty,url=http://minio.docker.localhost" \
  S3FS_ENDPOINT="http://minio.docker.localhost" \
  S3FS_ACCESSKEY="changeme1234" \
  S3FS_SECRETKEY="changeme1234"

docker run -it -v data:/data ubuntu /bin/bash
```


# Persistent storage on Amazon S3:
```
# Plugin
docker plugin install rexray/s3fs \
  LINUX_VOLUME_FILEMODE=0755 \
  S3FS_REGION=eu-west-1 \
  S3FS_OPTIONS="use_cache=/tmp,allow_other,use_path_request_style,nonempty,url=https://s3-eu-west-1.amazonaws.com" \
  S3FS_ACCESSKEY=mykey \
  S3FS_SECRETKEY=mysecret \
  --grant-all-permissions


# Create a volume
docker volume create --driver rexray/s3fs:latest --name s3-jupyter

# List the volume
docker volume ls

# Test the volume
docker run --rm -it -v s3-jupyter:/home/user/s3-jupyter cmihai/jupyter:v1 /bin/bash
```
