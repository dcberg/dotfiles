
FROM fatih/dev:latest

# install oh-my-zsh
RUN git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git /opt/.oh-my-zsh
RUN wget -O /opt/.oh-my-zsh/themes/honukai.zsh-theme https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm/master/honukai.zsh-theme

# pull kube-ps1 support
RUN wget -O /opt/kube-ps1 https://raw.githubusercontent.com/jonmosco/kube-ps1/master/kube-ps1.sh && chmod +x /opt/kube-ps1

# install kubectx
RUN git clone https://github.com/ahmetb/kubectx /opt/kubectx && \
   ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx && \
   ln -s /opt/kubectx/kubens /usr/local/bin/kubens && \
   mkdir -p ~/.oh-my-zsh/completions && \
   chmod -R 755 ~/.oh-my-zsh/completions && \
   ln -s /opt/kubectx/completion/kubectx.zsh ~/.oh-my-zsh/completions/_kubectx.zsh && \
   ln -s /opt/kubectx/completion/kubens.zsh ~/.oh-my-zsh/completions/_kubens.zsh

# install IBM Cloud CLI and plugins
RUN curl -sL https://ibm.biz/idt-installer | bash
RUN ibmcloud plugin install kubernetes-service
RUN ibmcloud plugin install container-registry

# copy IKS cluster scripts
COPY iks-merged-config.sh /opt/iks-merged-config.sh
COPY iks-download-cluster-configs.sh /opt/iks-download-cluster-configs.sh
RUN chmod +x /opt/iks-merged-config.sh && \
   chmod +x /opt/iks-download-cluster-configs.sh