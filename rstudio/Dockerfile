FROM jupyter/r-notebook

RUN python3 -m pip install jupyter-rsession-proxy

USER root

RUN apt-get update -qq --yes && \
    apt-get install --yes --no-install-recommends -qq \
        psmisc \
        sudo \
        libapparmor1 \
        lsb-release \
        cmake \
        libpq5 \
        libclang-dev > /dev/null

ENV RSTUDIO_URL https://download2.rstudio.org/server/bionic/amd64/rstudio-server-2022.02.3-492-amd64.deb
RUN curl --silent --location --fail ${RSTUDIO_URL} > /tmp/rstudio.deb && \
    dpkg -i /tmp/rstudio.deb && \
    rm /tmp/rstudio.deb

RUN mamba install --quiet --yes \
    'r-hmisc' \
    'r-lme4' \
    'r-lmertest' \
    'r-psych' \
    'r-nlme' \
    'r-randomforest' \
    'r-car' \
    'r-rstatix' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
    
ENV PATH=$PATH:/usr/lib/rstudio-server/bin
USER $NB_USER
