FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

#Update apt source and install basic tools
RUN sed -i s@/archive.ubuntu.com/@/mirrors.163.com/@g /etc/apt/sources.list \
      && apt clean \
      && apt update && apt install -fy --no-install-recommends \
            ca-certificates \
            wget \
            curl \
            git \
            zsh \
            emacs \
            vim \
            build-essential \
       && rm -rf /var/lib/apt/lists/*

ENV LC_ALL C.UTF-8
ENV TERM xterm-256color

#Install Oh My Zsh
ENV SHELL /bin/zsh
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
      && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
      && chsh -s /bin/zsh

#Install spacemacs
RUN git clone https://github.com/syl20bnr/spacemacs /root/.emacs.d
COPY emacs-pkg-install.el /root/.emacs.d/emacs-pkg-install.el
COPY .spacemacs /root/.spacemacs
RUN emacs -nw -batch -u root -q -kill
