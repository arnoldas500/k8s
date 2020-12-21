#file for creating ready to run labs for k8s
#create using docker build -t "akurbanovas/kara_k8s:latest" .
#change password and generate using jupyter notebook password or using echo -n password | sha1sum | awk '{print $1}'
#access from http://169.226.59.67:8882/kara
FROM akurbanovas/kara_kce:v5
MAINTAINER Arnoldas akurbanovas@albany.edu

#RUN pip3 install git+https://github.com/andrewm4894/my_utils.git#egg=my_utils

#RUN pip3 install kfp

#ENV NB_PREFIX /

CMD ["sh","-c", "jupyter lab --port=8882 --ip=0.0.0.0 --allow-root --no-browser --NotebookApp.allow_origin='*' --NotebookApp.base_url=kara --NotebookApp.password='sha1:83ab2528c099:61b8ae767417fcde727d65a
853eb28c3b6854168'"]
