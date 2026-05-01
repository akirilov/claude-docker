FROM ubuntu:24.04

# Install the dependencies
RUN apt-get update && apt-get upgrade -y
RUN apt install -y \
  git \
  curl \
  wget \
  vim

# Change User
USER ubuntu
WORKDIR /home/ubuntu

RUN curl -fsSL https://claude.ai/install.sh | bash
COPY settings.json .claude/settings.json
RUN echo 'PATH=~/.local/bin:$PATH' >> .bashrc

CMD ["bash"]
