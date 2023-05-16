FROM jupyter/scipy-notebook

ARG CUDA_VERSION=11.8

USER root

RUN conda init --system bash

USER ${NB_UID}

RUN conda install --quiet --yes -c pytorch -c nvidia \
        pytorch pytorch-cuda=${CUDA_VERSION} \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"

RUN echo "envs_dirs:" >> "${CONDA_DIR}/.condarc" \
    && echo "  - /home/jovyan/conda_envs/" >> "${CONDA_DIR}/.condarc" \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"

RUN mamba install --quiet --yes \
        'gh' \
        'git-lfs' \
        'nb_conda_kernels' \
        'conda-build' \
        'pyarrow' \
    && pip install --quiet \
# for running arbitrary web servers
        jupyter-server-proxy \
        dask-labextension \
# for Dask visualization
        graphviz \
        jupyterlab-git \
# adds un/zip to right-click context menu in file explorer
        jupyter-archive \
# command line progress bar
        rich \
    && mamba clean --all -f -y \
    && jupyter labextension install jupyterlab-plotly \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"