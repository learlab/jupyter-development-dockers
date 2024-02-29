FROM jupyter/scipy-notebook

USER root

RUN conda init --system bash

USER ${NB_UID}

# Shared location for HF models
ENV HF_HOME=/home/${NB_USER}/project-archive/huggingface

RUN echo "envs_dirs:" >> "${CONDA_DIR}/.condarc" \
        && echo "  - /home/${NB_USER}/conda_envs/" >> "${CONDA_DIR}/.condarc" \
        && fix-permissions "${CONDA_DIR}" \
        && fix-permissions "/home/${NB_USER}"

RUN mamba install --quiet --yes \
        gh \
        git-lfs \
        nb_conda_kernels \
        conda-build \
        pyarrow

RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

RUN pip3 install --quiet \
        # for running arbitrary web servers
        jupyter-server-proxy \
        #        dask-labextension \
        # for Dask visualization
        #        graphviz \
        jupyterlab-git \
        # adds un/zip to right-click context menu in file explorer
        jupyter-archive \
        # command line progress bar
        rich \
        && conda clean --all -f -y \
        && fix-permissions "${CONDA_DIR}" \
        && fix-permissions "/home/${NB_USER}"
