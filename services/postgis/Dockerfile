FROM postgres:10
LABEL name="cmihai/postgis" \
      version="1" \
      maintainer="Mihai Criveti <crivetimihai@gmail.com>" \
      description="PostgreSQL with PostGIS extensions.\
      This container contains PostgreSQL 10 with PostGIS"

# PARAMETERS
ARG OS_PACKAGES="postgresql-10-postgis-2.4 postgresql-10-postgis-2.4-scripts postgresql-contrib"

# INSTALL OS PACKAGES
RUN apt-get update \
    && apt-get install --no-install-recommends --yes ${OS_PACKAGES} \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
