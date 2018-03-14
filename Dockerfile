FROM jupyter/scipy-notebook

# launchbot-specific labels
LABEL name.launchbot.io="Practical Data Cleaning with Python"
LABEL workdir.launchbot.io="/home/jovyan"
LABEL description.launchbot.io="Practical Data Cleaning with Python"
LABEL 8888.port.launchbot.io="Start Tutorial"

#Set the working directory
WORKDIR /home/jovyan/

#Install dependencies and correct versions
USER root
COPY install_reqs.txt /home/jovyan/install_reqs.txt
RUN apt-get update && apt-get -y install graphviz &&\
    pip install --upgrade pip &&\
    pip install -r install_reqs.txt &&\
    pip install --upgrade numpy

# Add files
COPY cleaning-notebooks /home/jovyan/cleaning-notebooks
COPY data /home/jovyan/data
COPY solutions /home/jovyan/solutions
COPY validation-notebooks /home/jovyan/validation-notebooks 

# Allow user to write to directory
RUN chown -R $NB_USER /home/jovyan \
    && chmod -R 774 /home/jovyan

USER $NB_USER

# Expose the notebook port
EXPOSE 8888

# Start the notebook server
CMD jupyter notebook --no-browser --port 8888 --ip=* --NotebookApp.token='' --NotebookApp.disable_check_xsrf=True --NotebookApp.iopub_data_rate_limit=1.0e10
