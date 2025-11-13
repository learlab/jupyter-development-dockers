FROM jupyter/r-notebook

RUN python3 -m pip install jupyter-rsession-proxy \
    && echo "envs_dirs:" >> "${CONDA_DIR}/.condarc" \
    && echo "  - /home/jovyan/conda_envs/" >> "${CONDA_DIR}/.condarc" \
    && conda init bash \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"

USER root

# Install ONLY system packages that can't be provided by conda
# These are mainly for RStudio/Shiny Server and Quarto
RUN apt-get update -qq --yes && \
    apt-get install --yes --no-install-recommends -qq \
        # Required for RStudio/Quarto installation
        gdebi-core \
        wget \
        libssl-dev \
	psmisc \
	libclang-dev \
	lsb-release \ 
	# LaTeX for Quarto and Rmarkdown (system-only)
        lmodern \
        texlive \
        texlive-latex-extra \
        texlive-fonts-extra \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Quarto CLI
ARG QUARTO_URL=https://github.com/quarto-dev/quarto-cli/releases/download/v1.9.9/quarto-1.9.9-linux-amd64.deb
RUN wget ${QUARTO_URL} --quiet -O /tmp/quarto.deb \
    && gdebi --quiet --non-interactive /tmp/quarto.deb \
    && rm /tmp/quarto.deb

ARG RSTUDIO_URL=https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2025.09.1-401-amd64.deb
RUN wget ${RSTUDIO_URL} --quiet -O /tmp/rstudio.deb \
    && gdebi --quiet --non-interactive /tmp/rstudio.deb \
    && rm /tmp/rstudio.deb
    
ARG SHINY_URL=https://download3.rstudio.org/ubuntu-20.04/x86_64/shiny-server-1.5.23.1030-amd64.deb
RUN wget ${SHINY_URL} --quiet -O /tmp/shiny.deb \
    && gdebi --quiet --non-interactive /tmp/shiny.deb \
    && rm /tmp/shiny.deb

# Add rstudio-server to PATH
ENV PATH=$PATH:/usr/lib/rstudio-server/bin

# Switch back to jovyan user for conda installations
USER ${NB_UID}

# Install R package dependencies and development tools via conda
# This ensures binary compatibility with the conda R installation
RUN mamba install --quiet --yes \
    # Compiler toolchain (needed for source package compilation)
    'gxx_linux-64' \
    'gcc_linux-64' \
    'gfortran_linux-64' \
    # Development libraries (conda versions compatible with conda R)
    'cmake' \
    'make' \
    'pkg-config' \
    'libxml2' \
    'libcurl' \
    'openssl' \
    'libgit2' \
    'libssh2' \
    'zeromq' \
    'cairo' \
    'pango' \
    'harfbuzz' \
    'freetype' \
    'libpng' \
    'libtiff' \
    'jpeg' \
    'fontconfig' \
    'fribidi' \
    'glpk' \
    'protobuf' \
    # Required for string manipulation libraries
    'icu' \
    # Git tools
    'gh' \
    'git-lfs' \
    # Jupyter extensions
    'jupyter-server-proxy' \
    && mamba clean --all -f -y \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"

# Install R packages via conda (binary packages, much faster and more reliable)
RUN mamba install --quiet --yes \
    # Core R packages
    'r-tidyverse' \
    'r-quarto' \
    'r-stringi' \
    'r-stringr' \
    # Statistical packages
    'r-hmisc' \
    'r-lme4' \
    'r-lmertest' \
    'r-psych' \
    'r-nlme' \
    'r-car' \
    'r-lavaan' \
    'r-rstatix' \
    # Network/web packages
    'r-httr' \
    'r-curl' \
    'r-jsonlite' \
    'r-xml2' \
    # Development tools
    'r-devtools' \
    'r-remotes' \
    'r-pkgbuild' \
    && mamba clean --all -f -y \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"

# Set LD_LIBRARY_PATH to prioritize conda libraries
ENV LD_LIBRARY_PATH="${CONDA_DIR}/lib:${LD_LIBRARY_PATH}"

# Set locale (helpful for R)
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
