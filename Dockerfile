FROM ubuntu:18.04

ENV PACKER_VERSION=1.7.10
ENV TERRAFORM_VERSION=1.3.7
ARG INSPEC_VERSION=5.21.29
ARG INSPEC_CHANNEL=stable

ENV CHEF_LICENSE=accept-silent

RUN apt-get update && \
    apt-get install -y git unzip bash wget curl openssl
    
RUN wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip && \
    unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin && \
    rm packer_${PACKER_VERSION}_linux_amd64.zip -d /bin

RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin

RUN curl https://omnitruck.chef.io/install.sh | bash -s -- -P inspec
