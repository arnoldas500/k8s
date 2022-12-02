From tverous/pytorch-notebook:latest

# Switch to root user
USER root 

# Set user and group
ARG user=ksulia
ARG group=ksulia
ARG uid=22079
ARG gid=22079
RUN groupadd -g ${gid} ${group}
RUN useradd -u ${uid} -g ${group} -s /bin/sh -m ${user} # <--- the '-m' create a user home directory

# Switch to user
USER ${uid}:${gid}