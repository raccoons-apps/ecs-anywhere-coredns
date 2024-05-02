FROM coredns/coredns:1.11.1
COPY ./coredns.conf /etc/coredns/coredns.conf
ENTRYPOINT [ "/coredns", "-conf", "/etc/coredns/coredns.conf" ]
