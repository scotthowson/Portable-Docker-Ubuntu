# Use the official Ubuntu 20.04 image as a parent image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Enable i386 architecture and update package lists
RUN dpkg --add-architecture i386 && apt-get update

# Update system and install dependencies
RUN apt-get upgrade -y && \
    apt-get install -y bc bison build-essential ca-certificates cpio flex git \
    kmod libssl-dev libtinfo5 python2 sudo unzip wget xz-utils img2simg jq gnupg gperf \
    zip bzr curl libc6-dev libncurses5-dev:i386 x11proto-core-dev \
    libx11-dev:i386 libreadline6-dev:i386 libgl1-mesa-glx:i386 \
    libgl1-mesa-dev g++-multilib mingw-w64-i686-dev tofrodos \
    python3-markdown libxml2-utils xsltproc zlib1g-dev:i386 schedtool \
    liblz4-tool bc lzop imagemagick libncurses5 rsync python-is-python3

# Create bin directory in home and add it to PATH
RUN mkdir -p ~/bin && \
    echo "export PATH=\$PATH:\$HOME/bin" >> ~/.bashrc

# Download the repo script and make it executable
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && \
    chmod a+rx ~/bin/repo

# Manually install Oh My Zsh (optional, can be removed if not needed)
RUN git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh && \
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc && \
    sed -i "s|^export ZSH=.*|export ZSH=\"/root/.oh-my-zsh\"|g" ~/.zshrc && \
    sed -i "s/^plugins=(git)/plugins=(git docker zsh-autosuggestions zsh-syntax-highlighting zsh-completions zsh-nvm zsh-z)/" ~/.zshrc

# Install Zsh plugins (optional, can be removed if not needed)
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
    git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions && \
    git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm && \
    git clone https://github.com/agkozak/zsh-z ~/.oh-my-zsh/custom/plugins/zsh-z

# Add GitHub's SSH key to known hosts to avoid host key verification failures
RUN mkdir -p ~/.ssh && \
    ssh-keyscan github.com >> ~/.ssh/known_hosts

# Clone the AVB repository
RUN mkdir /avb && \
    cd /avb && \
    git clone https://android.googlesource.com/platform/external/avb

RUN git config --global user.email "${DOCKER_EMAIL}" && \
    git config --global user.name "${DOCKER_NAME}"

# Command to keep the container running
CMD ["/bin/bash"]