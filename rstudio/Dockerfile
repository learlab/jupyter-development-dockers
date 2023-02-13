FROM jupyter/r-notebook

RUN python3 -m pip install jupyter-rsession-proxy \
    && echo "envs_dirs:" >> "${CONDA_DIR}/.condarc" \
    && echo "  - /home/jovyan/conda_envs/" >> "${CONDA_DIR}/.condarc" \
    && conda init bash \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"

USER root

RUN wget --version

RUN apt-get update -qq --yes && \
    apt-get install --yes --no-install-recommends -qq \
        gdebi-core \
        wget > /dev/null
        # psmisc \
        # sudo \
        # libapparmor1 \
        # lsb-release \
        # cmake \
        # libpq5 \
        # libclang-dev > /dev/null

ENV RSTUDIO_URL https://download2.rstudio.org/server/bionic/amd64/rstudio-server-2022.12.0-353-amd64.deb
ENV SHINY_URL https://download3.rstudio.org/ubuntu-18.04/x86_64/shiny-server-1.5.20.1002-amd64.deb
RUN wget ${RSTUDIO_URL} -o /tmp/rstudio.deb \
    && wget ${SHINY_URL} -o /tmp/shiny.deb \
    && gdebi /tmp/rstudio.deb \
    && rm /tmp/rstudio.deb \
    && gdebi /tmp/shiny.deb \
    && rm /tmp/shiny.deb

USER ${NB_UID}

RUN mamba install --quiet --yes \
    'r-hmisc' \
    'r-lme4' \
    'r-lmertest' \
    'r-psych' \
    'r-nlme' \
    'r-car' \
    'r-rstatix' \
    'r-renv' \
    'r-quarto' \
    'jupyter-server-proxy' \
    && mamba clean --all -f -y \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"
    
ENV PATH=$PATH:/usr/lib/rstudio-server/bin