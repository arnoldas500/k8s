FROM codercom/code-server
COPY .vscode /home/coder/.local/share/code-server
RUN sudo chown -R coder:coder /home/coder/.local/share/code-server \
  && curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/