
FROM centos:centos8
LABEL author="ryuichi1208 <ryucrosskey@gmail.com>"
LABEL com.example.version="0.0.1-beta"

USER root:root
WORKDIR /home/app001

# yum
RUN yum -y update && yum clean all \
	&& yum install -y glibc-common bash-completion
ENV LANG ja_JP.UTF-8 \
	LANGUAGE ja_JP:ja \
	LC_ALL ja_JP.UTF-8

RUN yum -y install \
	make \
	curl \
	gdb \
	strace \
	devtool \
	zsh \
	vim \
	# neovim \
	python3 \
	golang \
	&& yum clean all \
	&& ldconfig

# dotfiles
COPY --chown=root:root dotfiles/zshrc.txt /root/.zshrc
COPY --chown=root:root dotfiles/vimrc.txt /root/.vimrc

# python
COPY --chown=root:root requirements.txt .
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
ENV PYTHONUNBUFFERED 1

# golang
ENV CGO_ENABLED 0 \
	GOOS linux

# HEALTHCHECK --interval=5m --timeout=3s \
  # CMD curl -f http://localhost/ || exit 1

ENTRYPOINT ["/bin/zsh"]
