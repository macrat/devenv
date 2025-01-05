FROM archlinux:latest

RUN yes | pacman -Syu \
        ctags \
        curl \
        gcc \
        git \
        go \
        make \
        neovim \
        openssh \
        python \
        python-pip \
        python-poetry \
        ripgrep \
        rxvt-unicode-terminfo \
        sudo \
        zsh \
        zsh-completions \
    && useradd -m -G wheel -s /bin/zsh ena \
	&& ln -s /usr/bin/nvim /usr/bin/vim \
	&& ln -s /usr/bin/nvim /usr/bin/vi \
    && echo -e '\n%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

COPY ./start-sshd /usr/bin/start-sshd

USER ena
ENV LANG=en_US.UTF-8
WORKDIR /home/ena
EXPOSE 22

RUN mkdir /home/ena/.ssh \
    && curl https://github.com/macrat.keys -o /home/ena/.ssh/authorized_keys \
    && git clone --depth=1 --recursive https://github.com/macrat/.dotfiles.git /home/ena/.dotfiles \
    && cd /home/ena/.dotfiles \
    && ./setup.sh

CMD ["/usr/bin/zsh"]
