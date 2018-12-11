FROM cmihai/python:v1
LABEL name="cmihai/jupyterlab" \
      version="1" \
      maintainer="Mihai Criveti <crivetimihai@gmail.com>" \
      description="Anaconda Python with Jupyter Lab\
      This container installs Anaconda Python 3 and Jupyter Lab."
SHELL ["/bin/bash", "-l", "-c"]
ENV DEBIAN_FRONTEND noninteractive

# PARAMETERS
ARG OS_PACKAGES="tzdata curl graphviz vim-nox gosu mc sqlite3 bash-completion sudo"
ARG LATEX_PACKAGES="texlive texlive-latex-base texlive-latex-extra texlive-xetex texlive-generic-recommended texlive-fonts-extra texlive-fonts-recommended pandoc"
ARG CONDA_PACKAGES="jupyterlab numpy pandas redis psycopg2 widgetsnbextension graphviz python-graphviz"
COPY pip.txt /tmp/pip.txt

# ROOT
USER root

# INSTALL OS PACKAGES
RUN apt-get update \
    && apt-get --no-install-recommends install --yes ${OS_PACKAGES} ${LATEX_PACKAGES}\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# SWITCH TO REGULAR USER
RUN mkdir /home/user/notebook && chown -R user:user /home/user/notebook \
    && echo 'user    ALL=NOPASSWD: ALL' >> /etc/sudoers
USER user

# INSTALL CONDA PACKAGES
RUN . ~/.profile \
    && unset SUDO_UID SUDO_GID SUDO_USER \
    && conda install --quiet --yes ${CONDA_PACKAGES} \
    && conda install -c conda-forge nodejs \
    && conda install -c pytorch pytorch torchvision \
    && conda install -c conda-forge keras \
    && conda install -c conda-forge tensorflow \
    && conda install -c conda-forge ipywidgets beakerx \
    && conda clean -y -all

# INSTALL PIP PACKAGES
RUN . ~/.profile \
    && python -m pip install --no-cache-dir --upgrade pip \
    && python -m pip install --no-cache-dir --upgrade -r /tmp/pip.txt

# WORKDIR
WORKDIR /home/user

# JUPYTERLAB EXTENSIONS
RUN jupyter labextension install jupyterlab-drawio \
    && jupyter labextension install jupyterlab_bokeh \
    && jupyter labextension install plotlywidget \
    && jupyter labextension install @jupyterlab/plotly-extension \
    && jupyter labextension install jupyterlab-chart-editor \
    && jupyter labextension install @jupyterlab/git \
    && jupyter serverextension enable --py jupyterlab_git \
    && jupyter labextension install @jupyterlab/latex \
    && jupyter labextension install @jupyterlab/toc \
    && jupyter labextension install @oriolmirosa/jupyterlab_materialdarker \
    && jupyter labextension install @jupyterlab/geojson-extension \
    && jupyter lab build

# WEKA
RUN export JAVA_HOME=/home/user/anaconda3/pkgs/openjdk* \
    && pip install javabridge \
    && pip install python-weka-wrapper3

# COMMAND and ENTRYPOINT:
COPY start-jupyter.sh /home/user/start-jupyter.sh
CMD ["/home/user/start-jupyter.sh"]

# NETWORK
EXPOSE 8888
