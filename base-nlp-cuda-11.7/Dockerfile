FROM jupyter/scipy-notebook

USER ${NB_UID}

RUN conda install --quiet --yes \
    -c pytorch -c nvidia \
    pytorch pytorch-cuda=11.7

RUN echo "envs_dirs:" >> "${CONDA_DIR}/.condarc" \
    && echo "  - /home/jovyan/conda_envs/" >> "${CONDA_DIR}/.condarc" \
    && conda init bash \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"

RUN mamba install --quiet --yes \
        'gh' \
        'nb_conda_kernels' \
        'conda-build' \
        'spacy' \
        'cupy' \
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
