FROM centos:centos8
LABEL author="ryuichi1208 <ryucrosskey@gmail.com>"

USER root:root
WORKDIR /home/app001

# yum
RUN yum -y update && yum clean all \
	&& yum install -y glibc-common bash-completion
ENV LANG ja_JP.UTF-8 \
	LANGUAGE ja_JP:ja \
	LC_ALL ja_JP.UTF-8

RUN yum -y install \
	zsh \
	vim \
	python3 \
	golang

# dotfiles
COPY --chown=root:root .zshrc /root
COPY --chown=root:root .vimrc /root

# python
COPY --chown=root:root requirements.txt .
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
ENV PYTHONUNBUFFERED 1

# golang
ENV CGO_ENABLED 0 \
	GOOS linux

ENTRYPOINT ["/bin/zsh"]
