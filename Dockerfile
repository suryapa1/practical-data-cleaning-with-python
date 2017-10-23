FROM jupyter/scipy-notebook

WORKDIR /home/jovyan/

COPY install_reqs.txt /home/jovyan/install_reqs.txt

#Install dependencies
RUN pip install --upgrade pip &&\
    pip install -r install_reqs.txt &&\
    pip install --upgrade numpy 

# Add files
COPY cleaning-notebooks /home/jovyan/cleaning-notebooks
COPY data /home/jovyan/data
COPY solutions /home/jovyan/solutions
COPY validation-notebooks /home/jovyan/validation-notebooks 

USER root
RUN chown -R jovyan:users /home/jovyan
USER $NB_USER

# Expose the notebook port
EXPOSE 8888

# Start the notebook server
CMD jupyter notebook --no-browser --port 8888 --ip=* --NotebookApp.token='' --NotebookApp.disable_check_xsrf=True
