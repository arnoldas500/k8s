#file for creating ready to run labs for k8s
FROM akurbanovas/kara_kce:v5
MAINTAINER Arnoldas akurbanovas@albany.edu

#RUN pip3 install git+https://github.com/andrewm4894/my_utils.git#egg=my_utils

#RUN pip3 install kfp

ENV NB_PREFIX /

CMD ["sh","-c", "jupyter lab --notebook-dir=/raid --ip=0.0.0.0 --no-browser --allow-root --port=8882 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url\
=${NB_PREFIX}"]
