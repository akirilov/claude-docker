FROM ubuntu:24.04

# Install the dependencies
RUN apt-get update && apt-get upgrade -y
RUN apt install -y \
  git \
  curl \
  wget \
  vim

# Define build arguments with default values
ARG USER_ID=1000
ARG GROUP_ID=1000

# Create the user and group inside the container
RUN groupmod -g $GROUP_ID ubuntu && \
    usermod -u $USER_ID -g $GROUP_ID ubuntu

# Change User
USER ubuntu
WORKDIR /home/ubuntu

RUN curl -fsSL https://claude.ai/install.sh | bash
RUN echo 'PATH=~/.local/bin:$PATH' >> .bashrc

CMD ["bash"]
