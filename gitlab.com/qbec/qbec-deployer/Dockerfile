FROM alpine:3.17.1

ENV QBEC_VER=0.15.2
ENV KUBECTL_VER=1.26.1
ENV HELM_VER=3.11.1
ENV PATH="/opt/yandex-cloud/bin:${PATH}"

RUN apk add --no-cache git git-crypt curl bash
    
RUN wget -O- https://github.com/splunk/qbec/releases/download/v${QBEC_VER}/qbec-linux-amd64.tar.gz | tar -C /tmp -xzf - && \
    mv /tmp/qbec /tmp/jsonnet-qbec /usr/local/bin/
    
RUN wget -O /usr/local/bin/kubectl https://dl.k8s.io/release/v${KUBECTL_VER}/bin/linux/amd64/kubectl && \
    chmod +x /usr/local/bin/kubectl
    
RUN wget -O- https://get.helm.sh/helm-v${HELM_VER}-linux-amd64.tar.gz | tar -C /tmp -zxf - && \
    mv /tmp/linux-amd64/helm /usr/local/bin/helm

RUN curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash -s -- -i /opt/yandex-cloud -n
    
RUN yc config profile create netology
