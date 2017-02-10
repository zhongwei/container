FROM ubuntu

#Install basic tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    curl \
    git \
    zsh \
    emacs \
    vim \
    && rm -rf /var/lib/apt/lists/*

#Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#Install spacemacs
RUN git clone https://github.com/syl20bnr/spacemacs /root/.emacs.d
COPY emacs-pkg-install.el /root/.emacs.d/emacs-pkg-install.el
COPY .spacemacs /root/.spacemacs
RUN emacs -nw -batch -u root -q -kill
RUN emacs -nw -batch -u root -q -kill
