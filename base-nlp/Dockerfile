FROM jupyter/scipy-notebook

USER ${NB_UID}

RUN conda install --quiet --yes \
    -c pytorch -c nvidia \
    pytorch torchvision torchaudio \
    pytorch-cuda=11.6

RUN echo "envs_dirs:" >> "${CONDA_DIR}/.condarc" && \
    echo "  - /home/jovyan/conda_envs/" >> "${CONDA_DIR}/.condarc" && \
    fix-permissions "${CONDA_DIR}"

RUN mamba install --quiet --yes \
        'gh' \
        'nb_conda_kernels' \
        'conda-build' \
        'spacy' \
        'cupy' \
        'pyarrow'
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
