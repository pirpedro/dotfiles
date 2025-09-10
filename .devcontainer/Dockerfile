# .devcontainer/Dockerfile
# Um único Dockerfile para Ubuntu 24.04, Pop!_OS 22.04 (simulado) e Fedora 40.
# Escolha com:  --build-arg DISTRO=ubuntu24|popos22|fedora40

ARG DISTRO=ubuntu

# ----- Escolha dinâmica da BASE via --from=target -----
FROM ${DISTRO} AS base
LABEL maintainer="Pedro Rodrigues <pir.pedro@gmail.com>"
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Pacotes base + locales (pt_BR e en_US)
RUN set -euxo pipefail; \
    if command -v apt-get >/dev/null 2>&1; then \
        export DEBIAN_FRONTEND=noninteractive; \
        apt-get update; \
        apt-get install -y --no-install-recommends sudo curl wget nano git locales ca-certificates tzdata; \
        echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen; \
        echo 'pt_BR.UTF-8 UTF-8' >> /etc/locale.gen; \
        locale-gen; \
    elif command -v dnf >/dev/null 2>&1; then \
        dnf -y install sudo curl wget nano git glibc-langpack-en glibc-langpack-pt ca-certificates findutils tzdata; \
        localedef -i en_US -f UTF-8 en_US.UTF-8 || true; \
        localedef -i pt_BR -f UTF-8 pt_BR.UTF-8 || true; \
        update-ca-trust; \
    else \
        echo 'Unsupported base image: need apt-get or dnf.' >&2; exit 1; \
    fi



# Usuário não-root app:app (1000:1000) com sudo sem senha
RUN set -eux \
#     && groupadd -g 1000 app \
#     && useradd -u 1000 -g app -s /bin/bash -m app \
#     && usermod -aG sudo app \
    && echo 'ubuntu    ALL=(ALL) NOPASSWD:ALL' >/etc/sudoers.d/90-ubuntu-nopasswd; chmod 0440 /etc/sudoers.d/90-ubuntu-nopasswd

USER ubuntu
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 TZ=America/Sao_Paulo
WORKDIR /home/ubuntu

# Instala chezmoi para o usuário app
RUN mkdir -p /home/ubuntu/.local/share && \
    sh -c "$(curl -fsLS get.chezmoi.io)"

CMD ["bash"]