FROM jupyter/r-notebook

RUN python3 -m pip install jupyter-rsession-proxy \
    && echo "envs_dirs:" >> "${CONDA_DIR}/.condarc" \
    && echo "  - /home/jovyan/conda_envs/" >> "${CONDA_DIR}/.condarc" \
    && conda init bash \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"

USER root

RUN apt-get update -qq --yes && \
    apt-get install --yes --no-install-recommends -qq \
        lmodern \
        gdebi-core\
        cmake  \
# Following are required for non-Conda install of tidyverse
        libfontconfig1-dev \
        libharfbuzz-dev \
        libfreetype6-dev \
        libpng-dev \
        libtiff5-dev \
        libjpeg-dev \
        libfribidi-dev > /dev/null

#ENV RSTUDIO_URL https://download2.rstudio.org/server/bionic/amd64/rstudio-server-2022.12.0-353-amd64.deb
# jupyter/r-notebook is built from Ubuntu 22.04
# Ubuntu 22.04 has migrated from libssl1.X to OpenSSL 3.0
# We need the daily build of RStudio server, which supports OpenSSL 3.0
# Once the stable release of RStudio server supports Ubuntu 22.04 (Jammy),
# we should switch back to stable.
ENV RSTUDIO_URL https://s3.amazonaws.com/rstudio-ide-build/server/jammy/amd64/rstudio-server-2023.03.0-daily-316-amd64.deb
RUN wget ${RSTUDIO_URL} --quiet -O /tmp/rstudio.deb \
    && gdebi --quiet --non-interactive /tmp/rstudio.deb \
    && rm /tmp/rstudio.deb
    
ENV SHINY_URL https://download3.rstudio.org/ubuntu-18.04/x86_64/shiny-server-1.5.20.1002-amd64.deb
RUN wget ${SHINY_URL} --quiet -O /tmp/shiny.deb \
    && gdebi --quiet --non-interactive /tmp/shiny.deb \
    && rm /tmp/shiny.deb

USER ${NB_UID}

RUN mamba install --quiet --yes \
    'gh' \
    'git-lfs' \
    'pkg-config' \
    'r-hmisc' \
    'r-lme4' \
    'r-lmertest' \
    'r-psych' \
    'r-nlme' \
    'r-car' \
    'r-rstatix' \
    'r-renv' \
    'r-quarto' \
    'r-tidyverse' \
    'jupyter-server-proxy' \
    && mamba clean --all -f -y \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"
    
ENV PATH=$PATH:/usr/lib/rstudio-server/bin