FROM archlinux:latest

RUN yes | pacman -Syu \
        curl \
        gcc \
        git \
        go \
        make \
        openssh \
        python \
        python-pip \
        python-poetry \
        rxvt-unicode-terminfo \
        sudo \
        vim \
        zsh \
        zsh-completions \
    && useradd -m -G wheel -s /bin/zsh ena \
    && echo -e '\n%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

COPY ./start.sh /usr/bin/start-devenv

USER ena
ENV LANG=en_US.UTF-8
WORKDIR /home/ena
EXPOSE 22

RUN mkdir /home/ena/.ssh \
    && curl https://github.com/macrat.keys -o /home/ena/.ssh/authorized_keys \
    && git clone --depth=1 --recursive https://github.com/macrat/.dotfiles.git /home/ena/.dotfiles \
    && cd /home/ena/.dotfiles \
    && ./deploy.sh

CMD ["/usr/bin/sudo", "/usr/bin/start-devenv"]
