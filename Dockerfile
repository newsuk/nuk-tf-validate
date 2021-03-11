# base image

FROM ubuntu:20.04

# Install tools and packages

RUN \
# Update
apt-get update && \
apt-get -y upgrade && \
# Install Tree, Findutils, Xjobs, Wget, Unzip
apt-get -y install tree findutils xjobs wget unzip git && \
# Install Terraform
wget https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_linux_amd64.zip && \
# Unzip 
unzip terraform_0.14.7_linux_amd64.zip && \
# Move to local bin
mv terraform /usr/local/bin/ && \
# Check to see if Terraform is installed
echo terraform --version 

COPY scripts/ /scripts/
RUN chmod +x /scripts/validate.sh
