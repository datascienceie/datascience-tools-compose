FROM ubuntu:18.10

# LABEL
LABEL name="cmihai/python" \
      version="1" \
      maintainer="Mihai Criveti <crivetimihai@gmail.com>" \
      description="Anaconda Python 3\
      This container installs Anaconda Python 3."

# ENVIRONMENT
SHELL ["/bin/bash", "-l", "-c"]
ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

# PARAMETERS
ARG OS_PACKAGES="ca-certificates wget bzip2 unzip build-essential git"

# ROOT
USER root

# INSTALL OS PACKAGES
RUN apt-get update \
    && apt-get --no-install-recommends install --yes ${OS_PACKAGES} \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# RUN AS REGULAR USER
RUN groupadd user \
    && useradd -d /home/user -ms /bin/bash -g user -G user user
USER user
WORKDIR /home/user

# INSTALL ANACONDA PYTHON
RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/conda-install.sh \
    && bash /tmp/conda-install.sh -b -p $HOME/anaconda3 > /tmp/conda-install.log 2>&1 \
    && rm /tmp/conda-install.sh \
    && echo 'export PATH="$HOME/anaconda3/bin:$PATH"' >> ~/.profile

# UPGRADE PIP
ENV PATH $HOME/anaconda3/bin:$PATH
RUN pip install --no-cache-dir --no-deps --upgrade pip

# COMMAND and ENTRYPOINT:
CMD ["/home/user/anaconda3/bin/python"]
