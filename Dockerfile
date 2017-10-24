FROM jupyter/base-notebook:ae885c0a6226
ARG JUPYTERHUB_VERSION=0.8
ARG HELM_VERSION=2.6.1

RUN pip install --no-cache jupyterhub==$JUPYTERHUB_VERSION

USER root
RUN apt-get update
RUN apt-get install -yq apt-transport-https curl apt-utils
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | tee /etc/apt/sources.list.d/azure-cli.list
RUN apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893
RUN apt-get update && apt-get install -yq azure-cli

#Kubectrl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

#HELM
RUN curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > /tmp/get_helm.sh
RUN chmod 700 /tmp/get_helm.sh
RUN ls /tmp
RUN /tmp/get_helm.sh --version v$HELM_VERSION



USER jovyan
