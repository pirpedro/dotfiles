FROM ubuntu:20.04 as base
LABEL maintainer="Pedro Rodrigues <pir.pedro@gmail.com>"

RUN apt update && \
  apt install -y sudo curl wget nano git locales

RUN locale-gen en_US en_US.UTF-8 pt_BR.UTF-8

RUN groupadd -g 1000 app \
  && useradd -u 1000 -g app -s /bin/bash -m app \
  && usermod -aG sudo app \
  && echo 'app    ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
  && chown -R app:app /home/app
# && echo 'PATH="${PATH:+${PATH}:}~/.local/bin"' >> /home/app/.bashrc

USER app

FROM base as end
RUN mkdir -p /home/app/.local/share \
  && cd /home/app/.local \
  && sh -c "$(curl -fsLS chezmoi.io/get)"