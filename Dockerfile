FROM coredns/coredns:1.11.1
COPY ./coredns.conf /etc/coredns/coredns.conf
ENV PROMETHEUS_PORT=9153
ENTRYPOINT [ "/coredns", "-conf", "/etc/coredns/coredns.conf" ]
