FROM ubuntu:18.04

ENV PACKER_VERSION=1.7.10
ENV TERRAFORM_VERSION=1.3.7

ENV CHEF_LICENSE=accept-silent

RUN apt-get update && \
    apt-get install -y git unzip bash wget curl openssl gnupg2 software-properties-common sshpass openssh-client
    
RUN wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip && \
    unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin && \
    rm packer_${PACKER_VERSION}_linux_amd64.zip -d /bin

RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin


RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu bionic main" | tee /etc/apt/sources.list.d/ansible.list && \
    echo "deb-src http://ppa.launchpad.net/ansible/ansible/ubuntu bionic main" | tee -a /etc/apt/sources.list.d/ansible.list && \
    RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 7BB9C367 && \
    apt-get update && \
    apt-get install -y ansible && \
    apt-get install -y python3 python3-pip && \
    pip3 install --upgrade pywinrm && \
    rm -rf /var/lib/apt/lists/*  /etc/apt/sources.list.d/ansible.list && \
    echo 'localhost' > /etc/ansible/hosts

RUN curl https://omnitruck.chef.io/install.sh | bash -s -- -P inspec
