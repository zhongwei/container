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
	    bat \
            sl \
	    nnn \
	    mc \
	    fonts-powerline \
       && rm -rf /var/lib/apt/lists/*

ENV LC_ALL C.UTF-8
ENV TERM xterm-256color

#Install Oh My Zsh
ENV SHELL /bin/zsh
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
      && git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k \
      && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting \
      && git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions \
      && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
      && sed -i s@ZSH_THEME=\"robbyrussell\"@ZSH_THEME=\"powerlevel9k/powerlevel9k\"@ ~/.zshrc \
      && sed -i 's@plugins=(git)@plugins=(git zsh-syntax-highlighting zsh-autosuggestions)@' ~/.zshrc \
      && chsh -s /bin/zsh

#Install build-essential
RUN build-essential 

#Install Go
Run apt install golang-1.14-go

#Install Rust
Run curl https://sh.rustup.rs -sSf | sh

#Install Nodejs
Run curl -sL https://deb.nodesource.com/setup_12.16.3 | bash - \
    && apt install -y nodejs

#Install spacemacs
RUN git clone https://github.com/syl20bnr/spacemacs /root/.emacs.d
COPY emacs-pkg-install.el /root/.emacs.d/emacs-pkg-install.el
COPY .spacemacs /root/.spacemacs
RUN emacs -nw -batch -u root -q -kill
