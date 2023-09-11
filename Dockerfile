ARG IMAGE=ubuntu
ARG TAG=22.04

FROM ${IMAGE}:${TAG}

# https://github.com/opencontainers/image-spec/blob/main/annotations.md#pre-defined-annotation-keys
LABEL org.opencontainers.image.description "© PremiScale, Inc. 2023"
LABEL org.opencontainers.image.licenses "GPLv3"
LABEL org.opencontainers.image.authors "Emma Doyle <emma@premiscale.com>"
LABEL org.opencontainers.image.documentation "https://premiscale.com"

USER root

ENV CRONITOR_TELEMETRY_KEY=""

# Install the Doppler CLI via apt for secrets retrieval.
RUN apt-get update \
    && apt-get install -y curl unzip \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd cronitor \
    && useradd -rm -d /opt/cronitor -s /bin/bash -g cronitor -G sudo -u 1001 cronitor

RUN curl -sOL "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install kubectl /usr/bin/kubectl && \
    rm kubectl

WORKDIR /app
COPY bin/run.sh .
RUN chown -R cronitor:cronitor /app \
    && chmod +x run.sh

USER cronitor

CMD [ "./run.sh" ]