
FROM centos:centos8
LABEL author="ryuichi1208 <ryucrosskey@gmail.com>"
LABEL com.example.version="0.0.1-beta"

USER root:root
WORKDIR /home/app001

ARG STUFFED_VERSION="1.0.0"
ARG STUFFED_ENABLE_ALL=""

# yum
RUN dnf -y update \
	&& dnf upgrade \
	&& dnf install -y \
	glibc-common \
	bash-completion \
	epel-release \
        && dnf clean all

ENV LANG ja_JP.UTF-8 \
	LANGUAGE ja_JP:ja \
	LC_ALL ja_JP.UTF-8 \
	TZ Asia/Tokyo

RUN dnf install -y \
	make \
	curl \
	gdb \
	git \
	cmake \
	net-tools \
	lsof \
	zsh \
	vim \
	python3 \
	golang \
	&& dnf clean all

# dotfiles
COPY --chown=root:root dotfiles/zshrc.txt /root/.zshrc
COPY --chown=root:root dotfiles/vimrc.txt /root/.vimrc

# python
COPY --chown=root:root requirements.txt .
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
ENV PYTHONUNBUFFERED 1

# golang
RUN go get -u github.com/labstack/echo \
	&& go get -v golang.org/x/tools/cmd/goimports
ENV CGO_ENABLED 0 \
	GOOS linux

# HEALTHCHECK --interval=5m --timeout=3s \
  # CMD curl -f http://localhost/ || exit 1

ENTRYPOINT ["/bin/zsh"]
