FROM willemvd/ubuntu-baseimage-unprivileged:latest
MAINTAINER willemvd <willemvd@github>

COPY . /bd_build

RUN /bd_build/prepare.sh && \
    /bd_build/system_services.sh && \
    /bd_build/utilities.sh && \
    /bd_build/cleanup.sh

EXPOSE 2222
VOLUME ["/etc/ssh/keys"]
USER git

ENTRYPOINT ["/sbin/my_init", "--"]
