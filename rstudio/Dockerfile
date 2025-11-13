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
# Network/web packages (httr, curl, devtools, etc.)
        libcurl4-openssl-dev \
        libssl-dev \
        libssh2-1-dev \
# LaTeX extras that may be used for Quarto and Rmarkdown
	texlive \
        texlive-latex-extra \
        texlive-fonts-extra \
# For graphing libraries like igraph and TidySEM
	libglpk-dev \
# Protobuf
	protobuf-compiler \
	libprotobuf-dev \	
# Graphics libraries for tidyverse
        libfontconfig1-dev \
        libharfbuzz-dev \
        libfreetype6-dev \
        libpng-dev \
        libtiff5-dev \
        libjpeg-dev \
        libcairo2-dev \
        libfribidi-dev > /dev/null

# Quarto CLI
ARG QUARTO_URL=https://github.com/quarto-dev/quarto-cli/releases/download/v1.9.9/quarto-1.9.9-linux-amd64.deb
RUN wget ${QUARTO_URL} --quiet -O /tmp/quarto.deb \
    && gdebi --quiet --non-interactive /tmp/quarto.deb \
    && rm /tmp/quarto.deb

ARG RSTUDIO_URL=https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2025.09.1-401-amd64.deb
RUN wget ${RSTUDIO_URL} --quiet -O /tmp/rstudio.deb \
    && gdebi --quiet --non-interactive /tmp/rstudio.deb \
    && rm /tmp/rstudio.deb
    
# ENV SHINY_URL https://download3.rstudio.org/ubuntu-18.04/x86_64/shiny-server-1.5.20.1002-amd64.deb
ARG SHINY_URL=https://download3.rstudio.org/ubuntu-20.04/x86_64/shiny-server-1.5.23.1030-amd64.deb
RUN wget ${SHINY_URL} --quiet -O /tmp/shiny.deb \
    && gdebi --quiet --non-interactive /tmp/shiny.deb \
    && rm /tmp/shiny.deb

# Install conda compiler toolchain and ensure libstdc++ compatibility
RUN mamba install --quiet --yes \
    'gxx_linux-64' \
    'gcc_linux-64' \
    && mamba clean --all -f -y \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"

# Set LD_LIBRARY_PATH to prioritize conda libraries
ENV LD_LIBRARY_PATH="${CONDA_DIR}/lib:${LD_LIBRARY_PATH}"

USER ${NB_UID}

RUN mamba install --quiet --yes \
    'gh' \
    'git-lfs' \
    'pkg-config' \
    'openssl' \
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
